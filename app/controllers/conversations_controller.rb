class ConversationsController < ApplicationController

  def index
    @conversations = Conversation.involving(current_user)
  end


  def new(originator, recipient)
    if Conversation.between(originator, recipient).exists?
      @conversation = Conversation.between(originator, recipient)
      redirect_to conversation_show_path(@conversation)
    else
      @conversation = Conversation.new(originator_id: originator.id, recipient_id: recipient.id)
    end
  end

  def create(originator, recipient)
    if Conversation.between(originator, recipient).exists?
      @conversation = Conversation.between(originator, recipient)
    else
    @conversation = Conversation.create(originator_id: originator.id, recipient_id: recipient.id)
    end
  end




end
