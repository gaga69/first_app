class LibraryController < ApplicationController
    before_action :authenticate_user!
    require 'net/http'
    require 'uri'
    require 'json'
    require 'will_paginate/array'

    def library_search
        @user = current_user
        pref_code = params[:place]
        if pref_code.nil?
        else
            place = Place.new
            place.prefecture_code = pref_code[:prefecture_code]
            @pref_name = place.prefecture.name
            uri = URI.parse URI.encode("http://api.calil.jp/citylist?pref=" + @pref_name)
            json = Net::HTTP.get(uri)
            city_json = json.gsub(/[();loadlibs]/,"(" => "", ")" => "", ";" => "", "loadlibs" => "")#parse error解消のため
            results = JSON.parse(city_json)
            cities = results.values.flatten #city_namesの配列にする
            @city_names = cities.paginate(:page => params[:page], :per_page => 10)
        end
    end

    def library_detail
        @user = current_user
        @library = library_json(params[:pref],params[:city]).select{ |i| i["libid"] == "#{params[:libid]}"}
        @favorite_library = FavoriteLibrary.new
        @lib = @user.favorite_libraries.find_by(libid: params[:libid]) #destroyでidを渡すため
    end

    def create
        @favorite_library = FavoriteLibrary.new(library_params)
        @favorite_library.save
        redirect_to library_detail_path(pref: @favorite_library.pref, city: @favorite_library.city, libid: @favorite_library.libid)
    end

    def destroy
        @favorite_library = current_user.favorite_libraries.find_by(id: params[:id])
        @favorite_library.destroy
        redirect_to user_path(current_user.id)
    end
    private 
        def library_params
            params.require(:favorite_library).permit(:user_id, :pref, :city, :libid, :systemid)
        end
end
