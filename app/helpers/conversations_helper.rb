module ConversationsHelper

  def find_originator_name(conversation)
    User.find_by(id: conversation.originator_id).username
  end

  def find_recipient_name(conversation)
    User.find_by(id: conversation.recipient_id).username
  end

  def find_originator(conversation)
    User.find_by(id: conversation.originator_id)
  end

  def find_recipient(conversation)
    User.find_by(id: conversation.recipient_id)
  end

  def find_studio_id(conversation)
    Studio.find_by(owner_id: conversation.recipient_id)
  end

  def display_date(message)
    message.created_at.strftime('%v') + " " + message.created_at.strftime('%r')
  end

end
