class GigsController < ApplicationController
  def index
    @page_title = "Find gigs"
    @page_description = "Find live music gigs near you"
    @gigs = Gig.where(approved: true)
=begin
    Geocoder.coordinates("placename")
    find(:all, :origin=>'94117', :order=>'distance')
=end
    render 'gigs/index'
  end
  
  def new
    @page_title = "Post a new gig"
    @page_description = ""
    @gig = Gig.new
    render 'gigs/new'
  end

  def show
    @gig = Gig.find(params[:id])
    @page_title = '[Gig] ' + @gig.event_name + ' @ ' + @gig.venue_name + ' on ' + @gig.from.strftime('%e/%m/%y')
    @page_description = ""
    render 'gigs/show'
    # XXX <time> for gig
  end
  
  def create
    # XXX captcha
  	gig = Gig.new(gig_params)
  	gig.errors.each do |message|
      puts message
    end
  	gig.save!
  	redirect_to :controller => 'gigs', :action => 'index'
  end
  
  def update
  #http://stackoverflow.com/questions/15946661/rails-update-action-fails-with-rails4-mongoid-create-ok
    # XXX authorize
    @gig = Gig.find(params[:id])
    @gig.update(moderated: true, approved: params[:commit] == "approve" ? true : false)
    
    respond_to do |format|
      if @gig.save
        format.html { render status: :ok, :nothing => true }
      else
        format.html { render status: :internal_server_error, :nothing => true }
      end
    end
  end
  
  def unmoderated
    # XXX authorize
    @page_title = "Moderate unapproved gigs"
    @page_description = ""
    @gigs = Gig.where(moderated: false)
    render 'gigs/unmoderated'
  end
  
  before_filter only: [:create] do
    params[:gig][:from] = Time.at(params[:gig][:from].to_i).to_datetime
    params[:gig][:to] = Time.at(params[:gig][:to].to_i).to_datetime
  end
  
private

  def gig_params
    params.require(:gig).permit(:ticket_cost, :from, :to, :event_name, :venue_name, :location)
  end
  
end
