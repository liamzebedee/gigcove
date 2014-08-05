# coding: utf-8
class ArtistsController < ApplicationController  
  def show
    @artist = Arist.find(params[:id])
    @page_title = "Artist — \"#{@artist.name}\""
    @page_description = ""
    render 'artists/show'
  end
end
