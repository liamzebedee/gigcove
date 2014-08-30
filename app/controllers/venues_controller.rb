# coding: utf-8
class VenuesController < ApplicationController
  def index
    # upper(name) makes case sensitivity not an issue when searching
    @venues = Venue.where("upper(name) LIKE upper(?)", "%#{params[:search]}%").limit(200)
    respond_to do |format|
      format.json { render json: @venues }
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
