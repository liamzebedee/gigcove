# coding: utf-8
class GenresController < ApplicationController
  def index
    # upper(name) makes case sensitivity not an issue when searching
    @genres = Genre.where("upper(name) LIKE upper(?)", "%#{params[:search]}%").limit(200)
    respond_to do |format|
      format.json { render json: @genres }
    end
  end
end
