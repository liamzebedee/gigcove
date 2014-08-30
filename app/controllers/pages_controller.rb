# coding: utf-8
class PagesController < ApplicationController
  def index
    @page_title = "GigCove — the easiest way to find live music gigs near you"
    @page_description = "Music is best when live, and it's even better when enjoyed with friends. GigCove shows you a moderated listing of gigs near you, personalised according to how much you can pay, when they are and other conditions (all ages, etc.). It's the best way of finding good quality live music gigs near you."
    @top_venues = Venue.where(approved: true).limit(3)
    @top_artists = Artist.where(approved: true).limit(3)
    render 'index'
  end
  
  def about
    @page_title = "About"
    @page_description = "The origins and history of GigCove."
    render 'about'
  end
 
  def contact
    @page_title = "Contact Us"
    @page_description = "How to contact the people behind GigCove."
    render 'contact'
  end
end
