class ApplicationController < ActionController::Base
    require 'net/http'
    helper_method :get_json

    def get_json(query)
        uri = URI.parse URI.encode("https://www.googleapis.com/books/v1/volumes?q=isbn:" + query)
        json = Net::HTTP.get(uri)
        json_encode = json.force_encoding("utf-8")
        @results = JSON.parse(json_encode)

    end


end
