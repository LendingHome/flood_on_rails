class GameController < ApplicationController
    def index
    	if Rails.cache.exist?("game")
    		@game = Rails.cache.read("game")
    	else
    		@game = Game.new(params[:size])
    		Rails.cache.write("game", @game)
    	end
        @worst_score = HighScore.all.order(:score).reverse_order.last.score
        @highscore = HighScore.new
    	
    end

    def create
        #Rails.logger.debug(params[:size])

        # if size was not sent, get the size of the last board
        if params[:size] == nil
            if Rails.cache.exist?("game")
                params[:size] = Rails.cache.read("game").size
            end
        end

    	@game = Game.new(params[:size])
        #Rails.logger.debug(@game.board.game_board.inspect)
    	Rails.cache.write("game", @game)
    	redirect_to :action => 'index'
    end

    def update
    	@color = params[:flood_color]
    	@game = Rails.cache.read("game")
    	@game.make_move(@color.to_i)
    	Rails.cache.write("game", @game)
    	redirect_to :action => 'index'
    end


	def save
        @saved_game = SavedGame.new(game_params)
        if @saved_game.save
            redirect_to '/game'
        end
	end
	
	def load
        @game = Game.new(nil,load_params[:id])
        Rails.cache.write("game", @game)
    	redirect_to :action => 'index'
	end

    private

    def game_params
        filtered_params = params.require(:saved_game).permit(:owner,:name,:board_type)
        @game = Rails.cache.read("game")
        filtered_params[:board] = @game.board.save_board(filtered_params[:board_type])
        unless filtered_params[:type] == 'new'
			filtered_params[:size] = @game.size
			filtered_params[:score] = @game.score
			filtered_params[:moves] = @game.moves_remaining
        end
        filtered_params
    end

    def load_params
        params.require(:game_id).permit(:id)
    end
end
