# coding: utf-8
include Geokit::Geocoders

class GigsController < ApplicationController
  before_filter only: [:create, :update] do
    # Date is in ISO8601 format
    params[:gig][:start_time] = Time.zone.parse(params[:gig][:start_time])
    params[:gig][:end_time] = Time.zone.parse(params[:gig][:end_time])
  end

  def new
    @page_title = "Post a new gig"
    @page_description = ""
    @gig = Gig.new

    render 'gigs/new'
  end

  def create
    gig = Gig.new
    gig.assign_attributes(gig_params_simple)
    gig.genres = process_genres_param
    gig.performances = process_performances_param(gig)

    if !(venue = Venue.find(venue_params[:id])).nil?
      gig.venue = venue
    else
      latlng = MultiGeocoder.geocode(venue_params[:location])
      gig.venue = Venue.create(cover_image: venue_params[:cover_image], latitude: latlng.lat, longitude: latlng.lng, name: venue_params[:name], location: venue_params[:location])
    end

    gig.save!
    redirect_to :controller => 'gigs', :action => 'index'
  end

  def update
    authorize!(:update, Gig)
    gig = Gig.find(params[:id])

    approved = (params[:commit] == "approve" ? true : false)
    gig.approved = approved
    gig.moderated = true
    
    gig.assign_attributes(gig_params_simple)
    gig.genres = process_genres_param
    performances = process_performances_param(gig)
    performances.each do |performance|
      performance.update(approved: approved)
      performance.artist.update(approved: approved)
    end
    gig.performances = performances
    gig.venue.update(approved: approved)

    respond_to do |format|
      if gig.save!
        format.html { render status: :ok, :nothing => true }
      else
        format.html { render status: :internal_server_error, :nothing => true }
      end
    end
  end

  def unmoderated
    authorize!(:moderate, Gig)
    @page_title = "Moderate unapproved gigs"
    @page_description = ""
    @gigs = Gig.where(moderated: false)
    render 'gigs/unmoderated'
  end

  def index
    @page_title = "Find live music gigs"
    @page_description = "Find live music gigs near you"
    @gigs = []
    latlng = []
    
    if params[:search] == nil
      render 'gigs/index'
    else
      if params[:search][:location] != ""
        # Try using location
        latlng = [params[:search][:latitude].to_f, params[:search][:longitude].to_f]
      else
        # params[:search][:latitude] != nil && params[:search][:longitude] != nil
        # XXX wrong error code, this is user's fault
        format.html { render status: :internal_server_error, :nothing => true }
      end
      distance_radius = 100

      @gigs = Gig.joins(:venue).within(distance_radius, origin: latlng).where(approved: true, end_time: DateTime.now..DateTime.now.next_month)
      render 'gigs/index'
    end
  end

  def show
    @gig = Gig.find(params[:id])
    if !@gig.approved
      render status: :internal_server_error, :nothing => true
      return
    end
    
    #title = '“' + @gig.title + '” '
    @page_title = 'Gig '+title
    @page_description = ""
    render 'gigs/show'
  end


  private

    def gig_params
      params.require(:gig).permit(:ticket_cost, :title, :link_to_source, :description, :start_time, :end_time, :genres, :performances)
    end

    # Only the params that correspond to this model´s attributes
    def gig_params_simple
      gig_params.slice(:ticket_cost, :start_time, :end_time, :title, :link_to_source, :description)
    end

    def venue_params
      params.require(:venue).permit(:location, :cover_image, :name, :id)
    end

    def process_genres_param
      genres = []
      gig_params[:genres].split(',').each do |genre_name|
        genre = Genre.find_by(name: genre_name)
        genres << genre if not genre.nil?
      end
      genres
    end

    def process_performances_param(gig)
      performances = []
      gig_params[:performances].split(',').each do |artist_name|
        artist = Artist.find_or_create_by(name: artist_name)
        performance = Performance.find_or_create_by(artist: artist, gig: gig)
        artist.performances << performance
        performances << performance
      end
      performances
    end

end
