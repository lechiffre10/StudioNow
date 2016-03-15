module UsersHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
  	!current_user.nil?
  end

  def session_user?
  	session[:user_id] = params[:id] ? true : false
  end

  def is_studio_owner?
    current_user == Studio.find_by(id: session[:studio_id]).owner
  end

end
