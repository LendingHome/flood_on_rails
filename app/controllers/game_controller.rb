class GameController < ApplicationController
    def index
    	if Rails.cache.exist?("game")
    		@game = Rails.cache.read("game")
    		#Rails.logger.debug("old game")
    		#Rails.logger.debug(@game.board.game_board).inspect
    	else
    		@game = Game.new
    		Rails.cache.write("game", @game)
    		#Rails.logger.debug("new game")
    	end
        @worst_score = HighScore.all.order(:score).last.score
    	#@board = @game.board
    	#session[:game] = @game
    	
    end

    def create
    	@game = Game.new
    	Rails.cache.write("game", @game)
    	redirect_to :action => 'index'
    end

    def update
    	@color = params[:flood_color]
    	#@game = Game.new(session[:game])
    	@game = Rails.cache.read("game")
    	#@board = @game.board
    	@game.make_move(@color.to_i)
    	#@board = @game.board
    	Rails.cache.write("game", @game)
    	redirect_to :action => 'index'
    end

end
