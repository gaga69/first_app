class PostsController < ApplicationController
    before_action :authenticate_user!

    def new
        @user = User.find(params[:user_id])
        @post = current_user.posts.build 
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "投稿できました！"
            redirect_to controller: :users, action: :show, id: @post.user_id
        else
            render new_user_post_path
        end
    end

    def destroy
        @post = current_user.posts.find_by(id: params[:id])
        @post.destroy
        redirect_to controller: :users, action: :show, id: @post.user_id
    end

    def edit
        @user = User.find(params[:user_id])
        @post = @user.posts.find_by(id: params[:id])
    end

    def update
        @post = current_user.posts.find(params[:id])
        if @post.update(post_params)
            flash[:success] = "編集できました！"
            redirect_to controller: :users, action: :show, id: @post.user_id
        else
            render edit_user_post_path
        end
    end

    def index
        @user = User.find(params[:user_id])
        @post_items = @user.posts.paginate(:page => params[:page], :per_page => 10)

    end

    private

    def post_params
        params.require(:post).permit(:book_title, :book_author, :content)
    end

end

