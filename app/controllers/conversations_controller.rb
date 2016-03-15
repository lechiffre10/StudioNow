class ConversationsController < ApplicationController

  def index
    @conversations = Conversation.where(originator_id: 1)
  end


  def new
    @conversation = Conversation.new
  end

  def create

  end


  private

  def conversation_params
    params.permit(:originator_id, :recipient_id)
  end


end
