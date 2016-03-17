module StudiosHelper
  def can_review_studio?(studio)
    current_user = User.find_by(id: session[:user_id])
    studio_receive_review = Studio.find_by(id: studio.id)
    total = []
    studio_receive_review.bookings.each do |booking|
      if booking.user_id == current_user.id && booking.end_time.past?
          total << booking.id
        end
      end
    total.length > 0 ? true : false
  end
end
