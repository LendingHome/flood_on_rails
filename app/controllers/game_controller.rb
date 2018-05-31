class GameController < ApplicationController
    def index
    	if Rails.cache.exist?("game")
    		@game = Rails.cache.read("game")
    	else
            if params[:size] != nil
    		      @game = Game.new(params[:size])
            else
                @game = Game.new('Medium') 
            end
    		Rails.cache.write("game", @game)
        end
        scores = HighScore.all.where('size = ?', @game.size)
        if scores.count > 9
            @worst_score = scores.order(:score).first.score
        else
            @worst_score = 0
        end
        @highscore = HighScore.new
    	
    end

    def create

        # if size was not sent, get the size of the last board
        if params[:size] == nil
            if Rails.cache.exist?("game")
                params[:size] = Rails.cache.read("game").size
            end
        end

    	@game = Game.new(params[:size])
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
