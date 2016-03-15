module MessagesHelper

  def find_sender_name(message)
    User.find_by(id: message.sender_id).username
  end


end
