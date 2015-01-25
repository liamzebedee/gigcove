# coding: utf-8
include Geokit::Geocoders

class GigsController < ApplicationController
  def index
    @page_title = ""
    @page_description = ""
    @gigs = []
    latlng = []

    if params[:search] == nil
      render 'gigs/index'
    else
      if params[:search][:location] != ""
        # Search for location coords
        latlng = Geocoder.geocode(params[:search][:location].to_s)
      else
        # Try using browser geolocation
        latlng = [params[:search][:latitude].to_f, params[:search][:longitude].to_f]
        if latlng == nill
          # XXX wrong error code, this is user's fault
          format.html { render status: :internal_server_error, :nothing => true }
        end
      end
      distance_radius = 100

      @gigs = Gig.approved_gigs.joins(:venue).within(distance_radius, origin: latlng).where(end_datetime: Time.zone.now..Time.zone.now.next_month)
      render json: @gigs
    end
  end

  def new
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
end
