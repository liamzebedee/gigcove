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
    gig_data = {
      ticket_cost: 5,
      start_time: "2014-09-02T20:30:00.000Z",
      end_time: "2014-09-02T21:00:00.000Z",
      title: "Gig Title",
      link_to_source: "http://example.com/link/to/source",
      description: "This is a gig.\n\nLet's have fun.",

      genres: "Rock,Classic",
      performances: "James and the believers,\"El classico\", Dave-O"
    }
    venue_data = {
      name: "The Waiting Room",
      location: "51 Browning St, West End, Brisbane"
    }
    
    assert_difference('Gig.count') do
      post :create, {
        venue: venue_data,
        gig: gig_data
      }
    end
  end

  test "should post update" do
  end

  test "should get unmoderated" do
    get :unmoderated
    assert_response :success
  end
end
