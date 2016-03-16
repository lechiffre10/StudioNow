class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = ["Please log in."]
      redirect_to root_path
    end
  end

  def send_message_to_owner(musician, studio)
    studio_owner = User.find_by(id: studio.owner_id)
    if Conversation.between(musician, studio_owner)
      conversation = Conversation.between(musician, studio_owner)
    else
      conversation = Conversation.create(originator_id: musician.id, recipient_id: studio_owner.id)
    end
    conversation.messages.create(sender_id: musician.id, content: "You have a booking request for your studio from #{musician.username}!")
  end

end
