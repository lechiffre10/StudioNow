module UsersHelper
  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
  	!current_user.nil?
  end	

  def session_user?
  	session[:user_id] = params[:id] ? true : false
  end
end
