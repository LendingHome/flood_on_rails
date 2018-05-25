class ComputerGameController < ApplicationController
	def index
		if Rails.cache.exist?("computergame")
    		@game = Rails.cache.read("computergame")
    		#Rails.logger.debug("old game")
    		#Rails.logger.debug(@game.board.game_board).inspect
    	else
    		@game = Computer_Game.new
    		Rails.cache.write("computergame", @game)
    		#Rails.logger.debug("new game")
    	end
        #@worst_score = HighScore.all.order(:score).last.score
        #@highscore = HighScore.new
    	#@board = @game.board
    	#session[:game] = @game
    	
    end

    def create
 		@game = Computer_Game.new
    	Rails.cache.write("computergame", @game)
    	redirect_to :action => 'index'
    end

    def update
    	@color = params[:flood_color]

    	#@game = Game.new(session[:game])
    	@game = Rails.cache.read("computergame")
    	#Rails.logger.debug(@game.user_board.game_board).inspect
    	#Rails.logger.debug(@game.comp_board.game_board).inspect
    	#Rails.logger.debug(@game.greedy_color)
    	#@board = @game.board
    	@game.make_user_move(@color.to_i)
    	#@board = @game.board
    	Rails.cache.write("computergame", @game)
    	redirect_to :action => 'index'
    end
end
