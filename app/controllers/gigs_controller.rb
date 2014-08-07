# coding: utf-8
class GigsController < ApplicationController
  def index
    @page_title = "Find gigs"
    @page_description = "Find live music gigs near you"
    @gigs = []
    latlng = []
    
    if params[:search] == nil
      render 'gigs/index'
    else
      if params[:search][:location] != ""
        # Try using location
        latlng = Geocoder.coordinates(params[:search][:location])
      elsif params[:search][:latitude] != nil && params[:search][:longitude] != nil
        latlng = [params[:search][:latitude].to_f, params[:search][:longitude].to_f]
      else
        # XXX wrong error code, this is user's fault
        format.html { render status: :internal_server_error, :nothing => true }
      end
      # Get all gigs in 150km radius that will be on within the next month
      radius = 100
      @gigs = Gig.near(latlng, radius, :units => :km).where(approved: true).where(:end_time => DateTime.now..DateTime.now.next_month)
      
      render 'gigs/index'
    end
    
  end
  
  def new
    @page_title = "Post a new gig"
    @page_description = ""
    @gig = Gig.new
    render 'gigs/new'
  end

  def show
    @gig = Gig.find(params[:id])
    if !@gig.approved
      render status: :internal_server_error, :nothing => true
      return
    end
    
    event_name = '“' + @gig.event_name + '” '
    @page_title = 'Gig ' + (@gig.event_name == "" ? "" : event_name) + '@ ' + @gig.venue_name + ' on ' + @gig.from.strftime("%b #{@gig.from.to_date.day.ordinalize}")
    @page_description = ""
    render 'gigs/show'
  end
  
  def create
    # XXX captcha
  	gig = Gig.new(gig_params)
    gig.moderated = false
    gig.approved = false

    # process genres
    params[:gig][:genres].split(',').each do |genre_name|
      genre = Genre.find_by(name: genre_name)
      gig.genres << genre if not genre.nil?
    end

    # process performances
    params[:gig][:performances].split(',').each do |artist_name|
      artist = Artist.create_with(approved: false).find_or_create_by(name: artist_name)
      performance = Performance.create_with(approved: false).find_or_create_by(artist: artist, gig: gig)
      performance.save!
      artist.performances << performance
      artist.save!
      gig.performances << performance
    end

    # process venue
    venue = Venue.create_with(approved: false, location: params[:venue][:location])
      .find_or_create_by(name: params[:venue][:name])
    venue.save!
    gig.venue = venue

  	gig.errors.each do |message|
      puts message
    end
  	gig.save!
  	redirect_to :controller => 'gigs', :action => 'index'
  end
  
  def update
    # http://stackoverflow.com/questions/15946661/rails-update-action-fails-with-rails4-mongoid-create-ok
    authorize!(:update, Gig)
    gig = Gig.find(params[:id])

    # process approved
    approved = (params[:commit] == "approve" ? true : false)

    # process genres
    genres = []
    params[:gig][:genres].split(',').each do |genre_name|
      genre = Genre.find_by(name: genre_name)
      genres << genre if not genre.nil?
    end

    # process performances
    performances = []
    params[:gig][:performances].split(',').each do |artist_name|
      artist = Artist.create_with(approved: false).find_or_create_by(name: artist_name)
      
      performance = Performance.create_with(approved: false).find_or_create_by(artist: artist, gig: gig)
      performance.approved = true

      artist.performances << performance
      artist.approved = true
      
      performances << performance
    end

    # process venue
    # TODO may not exist
    venue = Venue.create_with(approved: false).find_by(name: params[:venue][:name])
    venue.approved = true
    
    gig.update_attributes(gig_params.slice(:ticket_cost, :start_time, :end_time, :title, :link_to_source, :description))
    gig.venue = venue
    gig.genres = genres
    gig.performances = performances

    gig.update(moderated: true, approved: approved)
    
    respond_to do |format|
      if gig.save
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
  
  before_filter only: [:create] do
    #params[:gig][:start_time] = Time.at(params[:gig][:from].to_i).to_datetime
    #params[:gig][:end_time] = Time.at(params[:gig][:to].to_i).to_datetime
  end
  
private

  def gig_params
    params.require(:gig).permit(:ticket_cost, :start_time, :end_time, :title, :link_to_source, :description, :genres, :performances)
  end
  
end
