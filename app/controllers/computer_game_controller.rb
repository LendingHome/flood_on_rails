class ComputerGameController < ApplicationController
	def index
		if Rails.cache.exist?("computergame")
    		@game = Rails.cache.read("computergame")
    	else
            # TODO: allow game board size to vary
    		@game = Computer_Game.new(params[:size])
    		Rails.cache.write("computergame", @game)
    	end
    	
    end

    def create

        if params[:size] == nil
            if Rails.cache.exist?("computergame")
                params[:size] = Rails.cache.read("computergame").size
            end
        end

        # TODO: allow game board size to vary
 		@game = Computer_Game.new(params[:size])
    	Rails.cache.write("computergame", @game)
    	redirect_to :action => 'index'
    end

    def update
    	@color = params[:flood_color]
    	@game = Rails.cache.read("computergame")
    	@game.make_user_move(@color.to_i)
    	Rails.cache.write("computergame", @game)
    	redirect_to :action => 'index'
    end
end
