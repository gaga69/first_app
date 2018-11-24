class BooksController < ApplicationController
    before_action :authenticate_user!
    require 'net/http'
    require 'uri'
    require 'json'

    def book_search
        @user = current_user
        search = params[:search]
        if search.presence
        uri = URI.parse URI.encode("https://www.googleapis.com/books/v1/volumes?q=" + search)
        json = Net::HTTP.get(uri)
        results = JSON.parse(json)
        @items = results['items'] 
        end
    end

    def book_detail
        @user = current_user
        isbn = params[:isbn]
        get_json(isbn)
        @isbn = isbn
        @book_record = BookRecord.new
    end

    def create
        @book_record = BookRecord.new(record_params)
        if @book_record.save
            redirect_to user_path(current_user.id)
        else
            flash[:alert] = "登録済みです"
            redirect_to book_search_path
        end
    end

    def wish
        @user = User.find(params[:id])
        @lists = BookRecord.where(["user_id = ? and status = ?", @user.id,  "wish"])
    end

    def reading
        @user = User.find(params[:id])
        @lists = BookRecord.where(["user_id = ? and status = ?", @user.id,  "reading"])
    end

    def read
        @user = User.find(params[:id])
        @lists = BookRecord.where(["user_id = ? and status = ?", @user.id,  "read"])
    end

    def edit
        @user = User.find(params[:user_id])
        @book_record = BookRecord.find(params[:id])
        @isbn = @book_record.isbn.to_s
        get_json(@isbn)
    end

    def update
        @book_record = BookRecord.find(params[:id])
        if @book_record.update(record_params)
            redirect_to user_path(params[:user_id])
        end
    end

    def destroy
        @book_record = BookRecord.find(params[:id])
        @book_record.destroy
        redirect_to user_path(params[:user_id])
    end

    private

        def record_params
            params.require(:book_record).permit(:status, :isbn, :user_id)
        end
    
end
