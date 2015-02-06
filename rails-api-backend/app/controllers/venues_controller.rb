# coding: utf-8
class VenuesController < ApplicationController
  def index_params
    params.require(:search)
  end
  def index
    venues = Venue.find_similar_to_name(index_params[:search]).limit(100)
    render json: venues
  end

  def show_params
    params.require(:id)
  end
  def show
    venue = Venue.find(show_params[:id])
    render json: venue
  end

  private :index_params, :show_params
end