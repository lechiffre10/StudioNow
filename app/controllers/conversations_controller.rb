class ConversationsController < ApplicationController

  def index
    @conversations = Conversation.involving(current_user)
  end

  # def new
  #   recipient = User.find_by(id: params(:recipient_id))
  #   if Conversation.between(current_user, recipient).exists?
  #     @conversation = Conversation.between(current_user, recipient)
  #     redirect_to conversation_show_path(@conversation)
  #   else
  #     @conversation = Conversation.new(originator_id: originator.id, recipient_id: recipient.id)
  #   end
  # end

  def create
    recipient = User.find_by(id: params[:recipient_id])
    if Conversation.between(current_user, recipient)
      @conversation = Conversation.between(current_user, recipient)
      redirect_to conversation_path(@conversation)
    else
      @conversation = Conversation.create(originator_id: current_user.id, recipient_id: recipient.id)
      redirect_to conversation_path(@conversation)
    end
  end

  def show
    @conversation = Conversation.find_by(id: params[:id])
  end



end
