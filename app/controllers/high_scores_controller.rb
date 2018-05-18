class HighScoresController < ApplicationController
    def index
        @scores = HighScore.all
    end
end
