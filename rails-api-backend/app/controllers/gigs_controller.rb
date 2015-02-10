# coding: utf-8
include Geokit::Geocoders

class GigsController < ApplicationController
  def index_params
    params.require(:search).permit(:location, :latitude, :longitude, :cost, :distance_radius)
  end
  def index
    gigs = []
    latlng = []

    if index_params == nil[:name]
      render status: :not_acceptable
    else
      if index_params[:location] != ""
        # Search for location coords
        latlng = Geocoder.geocode(index_params[:location].to_s)
      else
        # Try using browser geolocation
        latlng = [index_params[:latitude].to_f, index_params[:longitude].to_f]
        if latlng == nil
          render json: {}, status: :not_acceptable
        end
      end

      gigs = Gig.approved_gigs.cheaper_than(index_params[:cost].to_i).joins(:venue).within(index_params[:distance_radius].to_f, origin: latlng).where(end_datetime: Time.zone.now..Time.zone.now.next_month)
      render json: gigs.to_json(:include => :tags)
    end
  end

  def gig_update_params
    params.require(:gig).permit(:cost, :start_datetime, :end_datetime, :name, :link_to_source, :description, :eighteen_plus, :approved, { :tags => [:name] })
  end
  def venue_update_params
    params.require(:venue).permit(:name, :location, :website, :id)
  end

  def create
    gig = Gig.new
    gig.cost = gig_update_params[:cost].to_i
    gig.start_datetime = Time.zone.parse(gig_update_params[:start_datetime]).to_datetime
    gig.end_datetime = Time.zone.parse(gig_update_params[:end_datetime]).to_datetime
    gig.name = gig_update_params[:name]
    gig.link_to_source = gig_update_params[:link_to_source]
    gig.description = gig_update_params[:description]
    gig.eighteen_plus = gig_update_params[:eighteen_plus]

    gig_update_params[:tags].each do |tag|
      tag = Tag.find_or_create_by(name: tag[:name].to_s)
      gig.tags << tag
    end

    # venue already exists
    venue = Venue.find_by_id(venue_update_params[:id])
    if venue == nil
      venue = Venue.new
      venue.name = venue_update_params[:name]
      venue.location = venue_update_params[:location]
      venue.website = venue_update_params[:website]
      venue.save!
    end
    gig.venue = venue

    gig.save!
    render json: {}, status: :created
  end

  def show_params
    params.require(:id)
  end
  def show
    gig = Gig.find(show_params)
    render json: gig
  end

  def update_params
    params.require(:id)
  end
  def update
    authorize!(:update, Gig)
    gig = Gig.find(update_params)
    gig.cost = gig_update_params[:cost].to_i
    gig.start_datetime = Time.zone.parse(gig_update_params[:start_datetime]).to_datetime
    gig.end_datetime = Time.zone.parse(gig_update_params[:end_datetime]).to_datetime
    gig.name = gig_update_params[:name]
    gig.link_to_source = gig_update_params[:link_to_source]
    gig.description = gig_update_params[:description]
    gig.eighteen_plus = gig_update_params[:eighteen_plus]

    gig.tags = []
    gig_update_params[:tags].each do |tag|
      gig.tags << Tag.create(name: tag[:name].to_s)
    end

    venue = Venue.find(venue_update_params[:id])
    venue.name = venue_update_params[:name]
    venue.location = venue_update_params[:location]
    venue.website = venue_update_params[:website]
    
    gig.moderated = true
    gig.approved = gig_update_params[:approved]
    venue.moderated = true
    venue.approved = gig_update_params[:approved]
    
    venue.save!
    gig.save!
    render status: :ok
  end

  def unmoderated
    authorize!(:unmoderated, Gig)
    gigs = Gig.unmoderated_gigs
    render json: gigs
  end

  private :index_params, :venue_update_params, :gig_update_params, :update_params, :show_params
end
