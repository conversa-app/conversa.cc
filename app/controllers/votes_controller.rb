class VotesController < ApplicationController

  def create
    comment = Comment.find_by(tid: params[:tid])
    @current_user.comment_votes.create!(comment: comment, vote: params[:vote])
    head :ok
  end
end
