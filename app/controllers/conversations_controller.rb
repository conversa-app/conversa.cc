class ConversationsController < ApplicationController

  before_action :find_organization

  def index
    @conversations = @org.conversations
  end

  def show
    @conversation = @org.conversations.find(params[:id])
  end

  def new
    @conversation = @org.conversations.build
  end

  def create
    @conversation = @org.conversations.build(conversation_params)
    if @conversation.save
      flash[:notice] = "The conversations was created"
      redirect_to conversation_path(@conversation)
    else
      render('new')
    end
  end

  def edit
    @conversation = @org.conversations.find(params[:id])
  end

  def update
    @conversation = @org.conversations.find(params[:id])
    if @conversation.update_attributes(conversation_params)
      flash[:notice] = "The conversation was updated"
      redirect_to conversation_path(@conversation)
    else
      render('edit')
    end
  end

  def delete
    @conversation = @org.conversations.build(conversation_params)
  end

  def destroy
    @conversation = @org.conversations.find(params[:id]).destroy
    flash[:notice] = "The conversation has been deleted"
    redirect_to conversation_path
  end

  private

  def conversation_params
    params.require(:conversation).permit!
  end

  def find_organization
    @org = current_user.organization
  end

end
