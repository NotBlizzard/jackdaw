class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.create(comment_params)
    @comment.photo_id = Photo.find(params[:photo_id]).id
    @comment.save
    respond_to do |format|
      format.json {
        email = User.find(@comment.user_id).email
        nick = User.find(@comment.user_id).nick
        render :json => JSON.parse(@comment.to_json).merge({ "nick" => nick, "email" => email }).to_json
      }
      format.html { redirect_to user_photo_path(params[:user_id], params[:id]) }
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    user = User.find(@comment.user_id)
    photo = Photo.find(@comment.photo_id)
    @comment.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.html {  redirect_to user_photo_path(user, photo) }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
