class AlbumsController < ApplicationController
  require 'securerandom'
    before_action :authenticate_user!, :except => [:show]

  def new
    @album = current_user.albums.new
  end

  def create
    @album = current_user.albums.create(album_params)
    @album.slug = SecureRandom.urlsafe_base64(10)
    @album.save
    redirect_to root_path
  end

  def show
    @album = Album.find_by slug: params[:slug]
  end

  def edit
    @album = current_user.albums.find_by slug: params[:id]
    @photos = current_user.photos
  end

  def destroy
    @album = current_user.albums.find_by slug: params[:slug]
    @album.destroy
    redirect_to current_user
  end

  def update
    @photo = current_user.photos.find(params[:photo_id])
    @album = current_user.albums.find(params[:id])
    if params[:method] == 'remove'
      @photo.album_id = nil
      @photo.save
    else
      @album.photos << @photo
    end
    if @album.save
      respond_to do |format|
        format.json { render :json => {} }
      end
    end
  end

  private
    def album_params
      params.require(:album).permit(:title)
    end
end
