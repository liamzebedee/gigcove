require 'json'

#http://matthewlehner.net/rails-api-testing-guidelines/
#http://dhartweg.roon.io/rspec-testing-for-a-json-api
#https://github.com/rspec/rspec-rails
describe "Gigs API" do
  it 'searches for gigs' do
  	# create a bunch of gigs with venues

  	# now search for them
  	search_params_latlng = {
  		search: {
  			cost: 50,
  			latitude: 29.1243213,
  			longitude: -21.14315
  		}
  	}

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