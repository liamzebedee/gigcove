require 'test_helper'

class GigsControllerTest < ActionController::TestCase
  test "should get index" do
  	get :index
  	assert_response :success
  end

  test "should get new" do
  	get :index
  	assert_response :success
  end

  test "should show gig" do
  	get :show, id: 1
  	assert_response :success
  end

  test "should create gig successfully" do
    gig = Gig.new
    gig_data = {
      ticket_cost: 5,
      start_time: gig.start_time,
      end_time: gig.end_time,
      title: "Gig Title",
      link_to_source: "http://example.com/link/to/source",
      description: "This is a gig.\n\nLet's have fun.",

      genres: "Rock,Classical",
      performances: "James and the believers,\"El classico\", Dave-O"
    }
    venue_data = {
      name: "The Waiting Room",
      location: "51 Browning St, West End, Brisbane",
      website: "http://example-venue.com"
    }
    
    assert lambda {
      post :create, {
        venue: venue_data,
        gig: gig_data
      }
      assert_response :success
      recent_gig = Gig.order("created_at").last

      (recent_gig.ticket_cost == gig_data.ticket_cost) &&
      (recent_gig.start_time == gig_data.start_time) &&
      (recent_gig.end_time == gig_data.end_time) &&
      (recent_gig.title == gig_data.title) &&
      (recent_gig.link_to_source == gig_data.link_to_source) &&
      (recent_gig.description == gig_data.description) &&
      (recent_gig.genres_str == gig_data.split(',')) &&
      (recent_gig.artists_str == gig_data.performances)

      (recent_gig.venue.name == venue_data.name) && 
      (recent_gig.venue.location == venue_data.location) && 
      (recent_gig.venue.website == venue_data.website)
    }
  end

  test "should post update" do
  end

  test "should get unmoderated" do
    get :unmoderated
    assert_response :success
  end
end
