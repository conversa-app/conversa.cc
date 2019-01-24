class CommentsController < ApplicationController

  def index
    @conversation = @current_user.organization.conversations.find(params[:conversation_id])
    @comments = @conversation.comments
  end

  def create
    @current_user.comments.create(
      content: params[:content], 
      conversation_id: params[:conversation_id],
      tid: params[:tid],
      votable: true)
    head :ok
  end

  def update
    @conversation = @current_user.organization.conversations.find(params[:conversation_id])
    comment = @conversation.comments.find(params[:id])
    comment.update_attributes(active: params[:active], votable: params[:votable])
    head :ok
  end
end
