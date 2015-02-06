# coding: utf-8
class TagsController < ApplicationController
  def index_params
  	params.require(:search)
  end
  def index
    @tags = Tag.find_similar_to_name(index_params[:search]).limit(100)
    render json: @tags
  end

  private :index_params
end