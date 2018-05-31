class SavedPageController < ApplicationController
    def index
        @saved_games = SavedGame.where(:owner => nil)

        if current_user
            @saved_games += SavedGame.where(:owner => current_user.username)
        else
            # Fixes a problem converting 'ActiveRecord:relation' => array 
            @saved_games += []
        end
        
        @saved_games.sort!{ |a,b| a.owner <=> b.owner || (b && 1) || 1 }
    end
end
