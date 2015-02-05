# coding: utf-8
class VenuesController < ApplicationController
  def index
    # upper(name) makes case sensitivity not an issue when searching
    # params[:approved]
    venues = Venue.where(approved: false).where("upper(name) LIKE upper(?)", "%#{params[:name]}%").limit(200)
    @venues_filtered = venues.map { |venue| {:id => venue.id, :name => venue.name} }
    render @venues_filtered
  end

  def show
    @venue = Venue.find(params[:id])
    @page_title = "Venue — \"#{@venue.name}\""
    @page_description = ""
    render 'venues/show'
  end

  def new
    authorize!(:new, Venue)
  end
end
