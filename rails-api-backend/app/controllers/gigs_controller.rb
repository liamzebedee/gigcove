# coding: utf-8
include Geokit::Geocoders

class GigsController < ApplicationController
  def index_params
    params.require(:search).permit(:location, :latitude, :longitude, :cost, :distance_radius)
  end
  def index
    @gigs = []
    latlng = []

    if index_params[:search] == nil
      render status: :not_acceptable
    else
      if index_params[:search][:location] != ""
        # Search for location coords
        latlng = Geocoder.geocode(index_params[:search][:location].to_s)
      else
        # Try using browser geolocation
        latlng = [index_params[:search][:latitude].to_f, index_params[:search][:longitude].to_f]
        if latlng == nil
          render status: :not_acceptable
        end
      end

      @gigs = Gig.approved_gigs.cheaper_than(index_params[:search][:cost].to_i).joins(:venue).within(index_params[:search][:distance_radius].to_f, origin: latlng).where(end_datetime: Time.zone.now..Time.zone.now.next_month)
      render json: @gigs
    end
  end

  def create_params
    params.require(:gig).permit(:cost, :start_datetime, :end_datetime, :name, :link_to_source, :description, :tags)
    params.require(:venue).permit(:name, :location, :website, :id)
  end
  def create
    gig = Gig.new
    gig.cost = create_params[:gig][:cost].to_d
    gig.start_datetime = Time.at(create_params[:gig][:start_datetime]).to_datetime
    gig.end_datetime = Time.at(create_params[:gig][:end_datetime]).to_datetime
    gig.name = create_params[:gig][:name].to_s
    gig.link_to_source = create_params[:gig][:link_to_source].to_s
    gig.description = create_params[:gig][:description].to_s

    create_params[:gig][:tags].each do |tag|
      gig.tags << Tag.create(tag.to_s)
    end

    # venue already exists
    venue = Venue.find(create_params[:venue][:id].to_i)
    if not venue.exists?
      venue = Venue.new
      venue.name = create_params[:venue][:name]
      venue.location = create_params[:venue][:location]
      venue.website = create_params[:venue][:website]
      venue.save!
    else
    gig.venue = venue

    gig.save!
    render status: :created
  end

  def show_params
    params.require(:id)
  end
  def show
    gig = Gig.find(show_params[:id])
    render json: gig
  end

  def update_params
    params.require(:gig).permit(:cost, :start_datetime, :end_datetime, :name, :link_to_source, :description, :tags, :approved)
    params.require(:venue).permit(:name, :location, :website, :id)
    params.require(:id)
  end
  def update
    authorize!(:update, Gig)
    gig = Gig.find(update_params[:id])
    gig.cost = create_params[:gig][:cost].to_d
    gig.start_datetime = Time.at(create_params[:gig][:start_datetime]).to_datetime
    gig.end_datetime = Time.at(create_params[:gig][:end_datetime]).to_datetime
    gig.name = create_params[:gig][:name].to_s
    gig.link_to_source = create_params[:gig][:link_to_source].to_s
    gig.description = create_params[:gig][:description].to_s

    gig.tags = []
    create_params[:gig][:tags].each do |tag|
      gig.tags << Tag.create(tag.to_s)
    end

    venue = Venue.find(update_params[:id])
    venue.name = create_params[:venue][:name]
    venue.location = create_params[:venue][:location]
    venue.website = create_params[:venue][:website]
    
    gig.moderated = true
    gig.approved = update_params[:gig][:approved]
    venue.moderated = true
    venue.approved = update_params[:gig][:approved]
    
    venue.save!
    gig.save!
    render status: :ok
  end

  def unmoderated
    authorize!(:unmoderated, Gig)
    gigs = Gig.unmoderated_gigs
    render json: gigs
  end

  private :index_params, :create_params, :update_params, :show_params
end
