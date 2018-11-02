class PostsController < ApplicationController
    before_action :authenticate_user!

    def new
        @post = current_user.posts.build if signed_in?
    end

    def create
        @user = current_user.id
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

