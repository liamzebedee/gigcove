# coding: utf-8
class ArtistsController < ApplicationController  
  def index
    # upper(name) makes case sensitivity not an issue when searching
    @artists = Artist.where("upper(name) LIKE upper(?)", "%#{params[:search]}%").limit(200)
    respond_to do |format|
      format.json { render json: @artists }
    end
  end

  def show
    @artist = Arist.find(params[:id])
    @page_title = "Artist — \"#{@artist.name}\""
    @page_description = ""
    render 'artists/show'
  end
end
