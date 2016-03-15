module ConversationsHelper

  def find_originator_name(conversation)
    User.find_by(id: conversation.originator_id).username
  end

  def find_recipient_name(conversation)
    User.find_by(id: conversation.recipient_id).username
  end

end
