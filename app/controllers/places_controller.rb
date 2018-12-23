class PlacesController < ApplicationController
    before_action :authenticate_user!
    def library_search
        @user = current_user
        pref = params[:name]


    end
end
