# coding: utf-8
class VenuesController < ApplicationController
  def show
    @venue = Venue.find(params[:id])
    @page_title = "Venue — \"#{@venue.name}\""
    @page_description = ""
    render 'venues/show'
  end
end
