class ApplicationController < ActionController::Base
    require 'net/http'
    helper_method :get_json
    helper_method :library_json

    def get_json(query)
        uri = URI.parse URI.encode("https://www.googleapis.com/books/v1/volumes?q=isbn:" + query)
        json = Net::HTTP.get(uri)
        @results = JSON.parse(json)
    end

    def library_json(pref_name, city_name)
        uri = URI.parse URI.encode("http://api.calil.jp/library?appkey=#{ENV['CALIL_KEY']}& \
              pref=" + pref_name + "&city=" + city_name + "&format=json" + "&callback=")
        json = Net::HTTP.get(uri)
        results = JSON.parse(json)
    end


end
