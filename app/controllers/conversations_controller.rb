class ConversationsController < ApplicationController

  respond_to :html, :js

  def index
    @conversations = Conversation.involving(current_user)
  end

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
    if @conversation
      @message = Message.new
      unless current_user == @conversation.recipient ||current_user == @conversation.originator
        flash[:errors] = ["You don't have access to this area!"]
        redirect_to root_path
      end
    else
      flash[:errors] = ["No conversation found!"]
      redirect_to root_path
    end
  end

  def destroy
    conversation = Conversation.find_by(id: params[:id])
    conversation.destroy
    redirect_to user_path(current_user)
  end

end
