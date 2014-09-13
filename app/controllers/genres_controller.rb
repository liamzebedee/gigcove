# coding: utf-8
class GenresController < ApplicationController
  def index
    @genres = Genre.find_similar_to_name(params[:search]).limit(200)
    respond_to do |format|
      format.json { render json: @genres }
    end
  end
end