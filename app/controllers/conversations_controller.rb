class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile_exists

  def index
    @conversations = Conversation.all
  end

  def create
    binding.pry
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    binding.pry
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end