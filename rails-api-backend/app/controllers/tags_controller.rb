# coding: utf-8

class TagsController < ApplicationController
  def index
  	json_params = ActiveSupport::JSON.decode(params[:q]).symbolize_keys
  	if json_params[:search] == ""
  		return render json: {}, status: :not_acceptable
  	end
    @tags = Tag.find_similar_to_name(json_params[:search]).limit(100)
    render json: @tags
  end
end