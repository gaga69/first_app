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
        # @thumbnail = 
        # @title = @results['items'][0]['volumeInfo']['title']
        # @author = @results['items'][0]['volumeInfo']['authors']
        # @publisher = @results['items'][0]['volumeInfo']['publisher']
        @isbn = isbn
        # @description = @results['items'][0]['volumeInfo']['description']
        @book_record = BookRecord.new
    end

    def create
        @book_record = BookRecord.new(record_params)
        @book_record.save
        redirect_to user_path(current_user.id)
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

    private

        def record_params
            params.require(:book_record).permit(:status, :isbn, :user_id)
        end
    
end
