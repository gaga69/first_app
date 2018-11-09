class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(:page => params[:page], :per_page => 10)
  end

  def index
    @users = User.all
    @user = current_user
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(:page => params[:page], :par_page => 10)
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page], par_page => 10)
    render 'show_follow'
  end

end
