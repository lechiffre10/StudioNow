class WelcomeController < ApplicationController
  def index
    @studios = Studio.all
    @studios.map.sort_by{|studio| studio.average_rating}
    @highest_rated_studios = @studios.first(5)
    render 'home'
  end
end
