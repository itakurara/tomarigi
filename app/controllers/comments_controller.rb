class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.new(comment_params.merge(user_id: current_user.id))
    if comment.save
      redirect_to lost_bird_path(comment.lost_bird_id)
    else
      # TODO
    end
  end

  def destroy
    comment = Comment.find(params.permit(:id)[:id])
    comment.destroy!

    redirect_to lost_bird_path(comment.lost_bird_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:lost_bird_id, :content)
  end
end
