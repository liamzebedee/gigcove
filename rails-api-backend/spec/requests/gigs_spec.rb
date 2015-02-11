require 'json'
require 'rails_helper'

def moderator_user
  User.find_by(email: "moderator@gigcove.com")
end

def json_api_response
	JSON.parse(response.body, symbolize_names: true)
end

def hash_to_url_json_params(params_hash)
  { q: params_hash.to_json }
end


describe "Gigs API" do
  it 'searches for gigs' do
    # create a bunch of gigs with venues
    gig_data_1 = {
      gig: {
        cost: 25,
        start_datetime: Time.zone.at(123213442).to_datetime.rfc3339,
        end_datetime: Time.zone.at(1324531421).to_datetime.rfc3339,
        name: "Gig numero 1",
        link_to_source: "http://test-gig-1.com",
        description: "Words cannot \n describe this gig.",
        tags: [{name:"music"}, {name:"dance"}, {name:"hip"}, {name:"TheFestival"}],
        eighteen_plus: false
      },
      venue: {
        name: "Brisbane Powerhouse",
        location: "119 Lamington Street, New Farm QLD",
        website: "http://brisbanepowerhouse.org"
      }
    }
    gig_data_2 = {
      gig: {
        cost: 10,
        start_datetime: Time.zone.at(123213442).to_datetime.rfc3339,
        end_datetime: Time.zone.at(1324531421).to_datetime.rfc3339,
        name: "Gig numero 2",
        link_to_source: "http://test-gig-2.com",
        description: "Words cannot \n describe this gig.",
        tags: [{name:"music"}, {name:"dance"}, {name:"hip"}, {name:"TheFestival"}],
        eighteen_plus: true
      },
      venue: {
        name: "The Crowbar",
        location: "Crowbar, 243 Brunswick Street, Brisbane",
        website: "http://www.crowbarbrisbane.com/"
      }
    }

    post "/api/gigs", gig_data_1.to_json, json_api_headers
    expect(Gig.last.tags.include? Tag.find_or_create_by(name: "music")).to be true
    post "/api/gigs", gig_data_2.to_json, json_api_headers

    gig_data_3 = {
      gig: {
        cost: 0,
        start_datetime: Time.zone.at(123213442).to_datetime.rfc3339,
        end_datetime: Time.zone.at(1324531421).to_datetime.rfc3339,
        name: "Gig numero 3",
        link_to_source: "http://test-gig-3.com",
        description: "Words cannot \n describe this gig.",
        tags: [{name:"music"}, {name:"dance"}, {name:"hip"}, {name:"TheFestival"}],
        eighteen_plus: true
      },
      venue: {
        id: Venue.last.id
      }
    }
    post "/api/gigs", gig_data_3.to_json, json_api_headers

    expect(Gig.count).to eq(3)

    expect(Venue.count).to eq(2)

    # We round to 3 decimal places to account for differences in various geolocators
    # http://gis.stackexchange.com/questions/8650/how-to-measure-the-accuracy-of-latitude-and-longitude
    # 2 decimal places is about 1km, so that's acceptable. Plus the IB used it.
    GEOLOCATION_DECIMAL_PLACES = 2
    venue_1 = Venue.where(location: gig_data_1[:venue][:location]).first
    puts venue_1.location
    venue_1_expected_latitude = -27.466335
    venue_1_expected_longitude = 153.051404
    expect(venue_1.latitude.round(GEOLOCATION_DECIMAL_PLACES)).to eq(venue_1_expected_latitude.round(GEOLOCATION_DECIMAL_PLACES))
    expect(venue_1.longitude.round(GEOLOCATION_DECIMAL_PLACES)).to eq(venue_1_expected_longitude.round(GEOLOCATION_DECIMAL_PLACES))

    # get them approved
    # stub authentication
    login(moderator_user)

    get '/api/gigs/unmoderated', {}, json_api_headers

    unmoderated_gigs = json_api_response
    
    unmoderated_gigs.each do |gig|
    	gig[:approved] = true
      patch "/api/gigs/#{gig[:id]}", {gig: gig}.to_json, json_api_headers
    end

    # now search for them
    search_params_latlng = {
      search: {
        cost: 20,
        latitude: venue_1_expected_latitude,
        longitude: venue_1_expected_longitude
      }
    }
    get '/api/gigs', hash_to_url_json_params(search_params_latlng), json_api_headers
    gigs_found = json_api_response
    expect(gigs_found.count).to eq 2

    search_params_location = {
      search: {
        cost: 50,
        location: "Brisbane, AU"
      }
    }
  end
end


describe 'Tags API' do
  it 'shows similar tags' do
    # create tags
    Tag.create!(name: 'music')
    Tag.create!(name: 'museum') # for sake of an example
    expect(Tag.count).to eq 2

    # find tags
    get '/api/tags', hash_to_url_json_params({ search: "mus" }), json_api_headers
    similar_tags = json_api_response
    expect(similar_tags[0]).to eq({:name => 'museum'})
    expect(similar_tags[1]).to eq({:name => 'music'})
  end

  it 'shows only specific tag' do
  	Tag.create!(name: 'music')
    Tag.create!(name: 'museum')
		
		get '/api/tags', hash_to_url_json_params({ search: "musi" }), json_api_headers
    
    similar_tags = json_api_response

    expect(similar_tags.count).to eq 1
    expect(similar_tags[0]).to eq({:name => "music"})
  end

  # it 'shows tags near a location, ranked by popularity'
end



describe 'Venues API' do
  it 'finds venues' do
    # create venues
    venue_1 = Venue.create!(
    		name: "Brisbane Powerhouse",
        location: "119 Lamington Street, New Farm QLD 4005",
        website: "http://brisbanepowerhouse.org"
    	)
    venue_2 = Venue.create!(
	    	name: "The Crowbar",
        location: "Crowbar, 243 Brunswick Street, Brisbane",
        website: "http://www.crowbarbrisbane.com/"
      )
    expect(Venue.count).to eq 2

    # search venues by name
    get '/api/venues', hash_to_url_json_params({search: "Brisbane"}), json_api_headers
    similar_venues = json_api_response

    expect(similar_venues.count).to eq 1
    expect(similar_venues[0][:name]).to eq venue_1.name
  end
end



describe 'Devise Auth API' do
  it 'registers user' do
  end

  it 'signs in, does authd stuff' do
  end
end