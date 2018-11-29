class ApplicationController < ActionController::Base
    require 'net/http'
    helper_method :get_json

    def get_json(query)
        uri = URI.parse URI.encode("https://www.googleapis.com/books/v1/volumes?q=isbn:" + query  + "&langRestrict=ja")
        json = Net::HTTP.get(uri)
        @results = JSON.parse(json)

    end


end
