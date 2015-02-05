# coding: utf-8
class TagsController < ApplicationController
  def index
    @tags = Tag.find_similar_to_name(params[:search]).limit(200)
    render @tags
  end

  
end