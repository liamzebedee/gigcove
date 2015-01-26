# coding: utf-8
class VenuesController < ApplicationController
  def index
    # upper(name) makes case sensitivity not an issue when searching
    # params[:approved]
    venues = Venue.where(approved: false).where("upper(name) LIKE upper(?)", "%#{params[:name]}%").limit(200)
    @venues_filtered = venues.map { |venue| {:id => venue.id, :name => venue.name} }
    respond_to do |format|
      format.json { render json: @venues_filtered }
      format.html { render json: @venues_filtered }
    end
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
