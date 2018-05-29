class HighScoresController < ApplicationController
    
    def index
        @scores = HighScore.all.order(:score).reverse_order
    end

    def new
    	@highscore = HighScore.new
    end

    def create
    	@highscore = HighScore.new(highscore_params)
    	# maintain top 10 high scores
    	HighScore.order(:score).reverse_order.last.destroy if HighScore.count > 9
    	if @highscore.save
    		redirect_to '/highscores'
    	else
    		render 'new'
    	end
    end

    private

    def highscore_params
		params.require(:high_score).permit(:name, :score).tap do |high_score|
			high_score[:name] = "Default" unless high_score[:name]
			high_score[:score] = 0 unless high_score[:score]
		end 
    end
end
