class LostBirdsController < ApplicationController
  def new
    @lost_bird ||= LostBird.new
  end

  def show
  end

  def create
    @lost_bird = LostBird.new(lost_bird_params)
    if @lost_bird.save
      redirect_to lost_bird_path(@lost_bird)
    else
      render :new
    end
  end

  private

  def lost_bird_params
    params.required(:lost_bird).permit(:status, :name, :address, :bird_id, :lost_at, :found_at, :ring_number, :description)
  end
end
