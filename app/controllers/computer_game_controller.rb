class ComputerGameController < ApplicationController
	def index
        @game = Rails.cache.fetch("computergame") {
            Computer_Game.new(params[:size])
        }  	
    end

    def create
        if params[:size] == nil
            if Rails.cache.exist?("computergame")
                params[:size] = Rails.cache.read("computergame").size
            end
        end

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
