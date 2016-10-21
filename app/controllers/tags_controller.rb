class TagsController < ApplicationController
  def show
    @photos = Photo.where("'#{params[:tag]}' = ANY (tags)")
    @tag = params[:tag]
  end
end
