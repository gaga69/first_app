class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @post_items = @user.feed.paginate(:page => params[:page], :per_page => 10)
  end

  def index
    @users = User.all
    @user = current_user
  end

  def following
    @title = "Follow"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(:page => params[:page], :per_page => 10)
    render 'show_follow'
  end
  
  def followers
    @title = "Follower"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page], :per_page => 10)
    render 'show_follow'
  end

  def current_user_home
    redirect_to current_user
  end

end
