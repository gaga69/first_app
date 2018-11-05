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

end
