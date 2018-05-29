class LandingPageController < ApplicationController
    def index
        @user = User.new
    end
end
