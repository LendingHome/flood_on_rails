class HighScoresController < ApplicationController
    
    def index
        @scores = HighScore.all.order(:score)
    end

    def new
    	@highscore = HighScore.new
    	render layout: 'modal'
    end

    def create
    	@highscore = HighScore.new(highscore_params)
    	# maintain top 10 high scores
    	HighScore.order(:score).last.destroy if HighScore.count > 9
    	if @highscore.save
    		redirect_to '/highscores'
    	else
    		render 'new'
    	end
    end

    private

    def highscore_params
    	params.require(:high_score).permit(:name, :score)
    end
end
