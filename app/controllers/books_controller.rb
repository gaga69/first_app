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
end
