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
            render new_post_path
        end
    end

    def destroy
    end

    private

    def post_params
        params.require(:post).permit(:book_title, :book_author, :content)
    end

end

