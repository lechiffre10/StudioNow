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

  def can_review_user?(user)
    current_user = User.find_by(id: session[:user_id])
    user_receive_review = User.find_by(id: user.id)
    total = []
    current_user.studios.each do |studio|
      studio.bookings.each do |booking|
        if booking.user_id == user_receive_review.id
          total << booking.id
        end
      end
    end
    total.length > 0 ? true : false
  end



end
