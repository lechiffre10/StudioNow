class RaterController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def create
    puts "i'm here! hello!"
    obj = params[:klass].classify.constantize.find(params[:id])
    obj.rate(params[:score].to_f, current_user, params[:dimension])
    render :json => true
  end
end
