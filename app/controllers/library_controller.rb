class LibraryController < ApplicationController
    before_action :authenticate_user!
    require 'net/http'
    require 'uri'
    require 'json'

    def library_search
        @user = current_user
        pref_code = params[:place]
        if pref_code.presence
            place = Place.new
            place.prefecture_code = pref_code[:prefecture_code]
            @pref_name = place.prefecture.name
            uri = URI.parse URI.encode("http://api.calil.jp/citylist?pref=" + @pref_name)
            json = Net::HTTP.get(uri)
            city_json = json.gsub(/[();loadlibs]/,"(" => "", ")" => "", ";" => "", "loadlibs" => "")#parse error解消のため
            results = JSON.parse(city_json)
            @city_names = results.values.flatten #valueを一つの配列にする
        end
    end
end
