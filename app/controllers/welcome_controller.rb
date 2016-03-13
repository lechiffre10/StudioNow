class WelcomeController < ApplicationController
  def index
    @studios = Studio.first(5)
    render 'home'
  end
end
