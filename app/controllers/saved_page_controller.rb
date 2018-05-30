class SavedPageController < ApplicationController
    def index
        @saved_games = SavedGame.where(:owner => nil)
        
        if current_user
            @saved_games += SavedGame.where(:owner => current_user.username)
        end

        puts @saved_games
    end
end
