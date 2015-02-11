# coding: utf-8
class VenuesController < ApplicationController
  def index
    json_params = ActiveSupport::JSON.decode(params[:q]).symbolize_keys
    venues = Venue.find_similar_to_name(json_params[:search]).limit(100)
    render json: venues
  end

  def show_params
    params.require(:id)
  end
  def show
    venue = Venue.find(show_params[:id])
    render json: venue
  end

  private :show_params
end