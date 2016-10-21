class UsersController < ApplicationController

  def show
    @user = User.find_by nick: params[:id]
  end
end
