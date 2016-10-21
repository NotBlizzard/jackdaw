require 'securerandom'

class PhotosController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  def new
    @photo = current_user.photos.new
  end

  def create
    @photo = current_user.photos.new(photo_params)
    @photo.tags = params[:tags].split(/, |,/)
    if @photo.save
      redirect_to user_photo_path(current_user.nick, @photo.slug)
    else
      return render 'new'
    end
  end

  def index
    @photos = Photo.all
  end

  def edit
    @photo = Photo.find_by slug: params[:id]
  end

  def update
    @photo = Photo.find_by slug: params[:id]
    @photo.update(photo_params)
    redirect_to user_photo_path(User.find(@photo.user_id).nick, @photo.slug)
  end

  def show
    @photo = Photo.find_by slug: params[:slug]
    @comment = Comment.new
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy
    redirect_to user_path(current_user)
  end

  private
    def photo_params
      params.require(:photo).permit(:title, :tags, :photo)
    end
end
