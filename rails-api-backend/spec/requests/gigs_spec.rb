require 'json'
require 'rails_helper'

#http://matthewlehner.net/rails-api-testing-guidelines/
#http://dhartweg.roon.io/rspec-testing-for-a-json-api
#https://github.com/rspec/rspec-rails
def moderator_user
  User.find_by(email: "moderator@gigcove.com")
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
        location: "119 Lamington Street, New Farm QLD 4005",
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
    # 3 decimal places is about 100m, so that's acceptable. Plus the IB used it.
    venue_1 = Venue.where(location: gig_data_1[:venue][:location]).first
    venue_1_expected_latitude = -27.466335
    venue_1_expected_longitude = 153.051404
    expect(venue_1.latitude.round(3)).to eq(venue_1_expected_latitude.round(3))
    expect(venue_1.longitude.round(3)).to eq(venue_1_expected_longitude.round(3))


    # get them approved
    # stub authentication
    login(moderator_user)

    get '/api/gigs/unmoderated', {}, json_api_headers

    unmoderated_gigs = JSON.parse(response.body, symbolize_names: true)
    
    unmoderated_gigs.each do |gig|
    	gig[:approved] = true
    	a = {gig: gig}
      patch "/api/gigs/#{gig[:id]}", a.to_json, json_api_headers
    end

    # now search for them
    search_params_latlng = {
      search: {
        cost: 50,
        latitude: venue_1_expected_latitude,
        longitude: venue_1_expected_longitude
      }
    }
    get '/api/gigs', search_params_latlng.to_json, json_api_headers
    puts response.body

    search_params_location = {
      search: {
        cost: 50,
        location: "Brisbane, AU"
      }
    }
  end

  it 'moderates gigs' do
    # show unmoderated gigs


    # update gig moderation status


  end

  it 'shows gig' do
  end
end



describe 'Tags API' do
  it 'shows similar tags' do
    # create tags


    # find tags


  end

  # it 'shows tags near a location, ranked by popularity'
end



describe 'Venues API' do
  it 'finds venues' do
    # create venues


    # search venues by location


  end

  it 'update venue info' do
  end
end



describe 'Devise Auth API' do
  it 'registers user' do
  end

  it 'signs in, does authd stuff' do
  end
end
