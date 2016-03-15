module MessagesHelper

  def find_sender_name(message)
    User.find_by(id: message.sender_id).username
  end

  def find_sender(message)
    User.find_by(id: message.sender_id)
  end


end
