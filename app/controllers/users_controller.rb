class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follows]
  def show
  end

  def follows
    @following = @user.following
    @followers = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end