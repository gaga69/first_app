class BooksController < ApplicationController
    before_action :authenticate_user!
    require 'net/http'
    require 'uri'
    require 'json'

    def book_search
        search = params[:search]
        if search.presence
        uri = URI.parse URI.encode("https://www.googleapis.com/books/v1/volumes?q=" + search)
        json = Net::HTTP.get(uri)
        results = JSON.parse(json)
        @items = results['items'] 
        end
    end

    def book_detail
        book_id = params[:book_id]
        uri = URI.parse URI.encode("https://www.googleapis.com/books/v1/volumes?q=id:" + book_id)
        json = Net::HTTP.get(uri)
        results = JSON.parse(json)
        @thumbnail = results['items'][0]['volumeInfo']['imageLinks']['smallThumbnail']
        @title = results['items'][0]['volumeInfo']['title']
        @author = results['items'][0]['volumeInfo']['authors']
        @publisher = results['items'][0]['volumeInfo']['publisher']
        @description = results['items'][0]['volumeInfo']['description']
    end

end
