# coding: utf-8
include Geokit::Geocoders

class GigsController < ApplicationController
  def index_params
    params.require(:search).permit(:location, :latitude, :longitude, :cost)
  end
  def index
    @gigs = []
    latlng = []

    if index_params[:search] == nil
      render status: :not_acceptable
    else
      if index_params[:search][:location] != ""
        # Search for location coords
        latlng = Geocoder.geocode(index_params[:search][:location].to_s)
      else
        # Try using browser geolocation
        latlng = [index_params[:search][:latitude].to_f, index_params[:search][:longitude].to_f]
        if latlng == nil
          render status: :not_acceptable
        end
      end
      distance_radius = 100

      @gigs = Gig.approved_gigs.cheaper_than(index_params[:search][:cost].to_i).joins(:venue).within(distance_radius, origin: latlng).where(end_datetime: Time.zone.now..Time.zone.now.next_month)
      render json: @gigs
    end
  end

  def create
    # process parameters securely
    # create tags as unapproved
    # create gig as unapproved
    # create venue as unapproved
    # geolocate venue
    # save and redirect
  end

  def unmoderated
    # update gig simple data
    # delete the old unused tags
    # update simple venue data
    # re-geolocate venue
    # approve venue and gig
    # save
  end

  private :index_params
end
