class BooksController < ApplicationController
    before_action :authenticate_user!
    require 'net/http'
    require 'uri'
    require 'json'
    require 'will_paginate/array'

    def book_search
        @user = current_user
        search = params[:search]
        if search.presence
            uri = URI.parse URI.encode("https://www.googleapis.com/books/v1/volumes?q=" + search + "&langRestrict=ja" + "&maxResults=40")
            json = Net::HTTP.get(uri)
            results = JSON.parse(json)
            items = results['items']
            isbn_items = []
            items.each do |item|
                if item.dig("volumeInfo", "industryIdentifiers", 1, "type") == "ISBN_13"
                    isbn_items.push(item)
                end
            end
            @book_items = isbn_items.paginate(:page => params[:page], :per_page => 10)
        end
    end

    def book_detail
        @user = current_user
        @isbn = params[:isbn]
        get_json(@isbn)
        @book_record = BookRecord.new
        @posts = Post.where(["isbn = ?", @isbn])
        #図書館に対して蔵書の有無と貸出状況を問い合わせる
        systemids = FavoriteLibrary.where(["user_id = ?", @user.id]).select(:systemid).distinct
        arry_systemid = []
        systemids.each do |systemid|
            arry_systemid.push(systemid[:systemid])
        end
        query_systemid = arry_systemid.join(",")
        uri = URI.parse URI.encode("https://api.calil.jp/check?appkey=#{ENV['CALIL_KEY']}" + "&isbn=#{@isbn}" + "&systemid=#{query_systemid}" + "&callback=no")
        json = Net::HTTP.get(uri)
        results = JSON.parse(json)
        p results
        #呼び出しを繰り返す
        unless results["continue"] == 0    
            while results["continue"] < 2 do
                sleep(3)
                uri = URI.parse URI.encode("https://api.calil.jp/check?appkey=#{ENV['CALIL_KEY']}" + "&session=#{results["session"]}" + "&callback=no")
                json = Net::HTTP.get(uri)
                results = JSON.parse(json)
                break if results["continue"] == 0
            end
        end
        p results
    end

    def create
        @book_record = BookRecord.new(record_params)
        if @book_record.save
            redirect_to user_path(current_user.id)
        elsif @book_record.isbn.presence
            flash[:alert] = "登録済みです"
            redirect_to book_detail_path(isbn: @book_record.isbn)
        else @book_record.status.nil?
            flash[:alert] = "選択してください"
            redirect_to book_detail_path(isbn: @book_record.isbn)
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
        @posts = Post.where(["isbn = ?", @isbn])
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
