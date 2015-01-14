# coding: utf-8
class PagesController < ApplicationController
  def index
    @page_title = "GigCove — the easiest way to find live music gigs near you"
    @page_description = ""
    @top_venues = Venue.where(approved: true).limit(3)
    render 'index'
  end
  
  def about
    @page_title = "About"
    @page_description = "The origins and history of GigCove."
    render 'about'
  end

  def contribute
    @page_title = "Contribute"
    @page_description = ""
    render 'contribute'
  end
end
