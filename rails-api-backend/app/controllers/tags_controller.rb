# coding: utf-8
class TagsController < ApplicationController
  def index
    @tags = Tag.find_similar_to_name(params[:search]).limit(200)
    respond_to do |format|
      format.json { render json: @tags }
    end
  end
end