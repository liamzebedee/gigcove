class GigsController < ApplicationController
  def index
    @page_title = "Live Music Gigs"
    @page_description = ""
    @gigs = Gig.all
    render 'gigs/index'
  end
  
  def new
    @page_title = "Post a new gig"
    @page_description = ""
    render 'gigs/new'
  end

  def show
    @page_title = "" # TODO gig name
    @page_description = "" # TODO gig description
    render 'gigs/show'
  end
end
