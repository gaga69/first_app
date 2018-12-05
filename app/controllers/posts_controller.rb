class PostsController < ApplicationController
    before_action :authenticate_user!

    def new
        @user = User.find(params[:user_id])
        @book_record = BookRecord.find(params[:book_id])
        @post = current_user.posts.build 
    end

    def create
        @book_record = BookRecord.where(["user_id = ? and isbn = ?", params[:user_id], params[:post][:isbn]])
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "投稿できました！"
            redirect_to controller: :users, action: :show, id: @post.user_id
        elsif @post.content.empty? then
            @user = User.find(params[:user_id])
            redirect_back(fallback_location: new_user_post_path, alert: "感想を入力してください")
        else @post.content.presence 
            redirect_back(fallback_location: new_user_post_path, alert: "投稿済みの感想は編集してください")
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
            @user = User.find(params[:user_id])
            render 'posts/edit', id: @user.id
        end
    end

    def index
        @user = User.find(params[:user_id])
        @post_items = @user.posts.paginate(:page => params[:page], :per_page => 10)

    end

    private

    def post_params
        params.require(:post).permit(:content, :isbn)
    end

end

