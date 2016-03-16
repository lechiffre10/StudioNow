class MessagesController < ApplicationController
  respond_to :html, :js

  def new
    @conversation = Conversation.find_by(id: params[:conversation_id])
    @message = Message.new(conversation_id: @conversation.id, sender_id: current_user.id)
  end

  def create
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
    @conversation = Conversation.find_by(id: params[:conversation_id])
    message = Message.create(content: params[:message][:content], sender_id: current_user.id, conversation_id: @conversation.id)
    if message.save
      redirect_to conversation_path(@conversation)
    else
      flash[:errors] = message.errors.full_messages
      redirect_to :back
    end
  end




  private

  def message_params
    params.require(:message).permit(:content, :sender_id, :conversation_id)
  end

end
