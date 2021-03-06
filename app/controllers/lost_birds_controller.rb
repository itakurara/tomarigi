class LostBirdsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    @lost_bird ||= LostBird.new
  end

  def show
    @lost_bird = LostBird.find(params.permit(:id)[:id])
    @comment = Comment.new(lost_bird_id: @lost_bird.id)
    @comments = @lost_bird.comments
  end

  def create
    @lost_bird = LostBird.new(lost_bird_params.merge(user_id: current_user.id))
    if @lost_bird.save
      redirect_to lost_bird_path(@lost_bird)
    else
      render :new
    end
  end

  def search
    @search_results = LostBird.lookup(search_params).records.to_a
  end

  private

  def lost_bird_params
    params.required(:lost_bird).permit(:status, :name, :lost_address, :found_address, :bird_id, :lost_at, :found_at, :ring_number, :description, photos: [])
  end

  def search_params
    params.required(:q).permit(:status, :kind, :ring_number, :description, :lost_address, :found_address, :date, :date_range, :include_resolved, :meet_all_conditions)
  end
end
