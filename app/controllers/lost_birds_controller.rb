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

  def search
    @search_results = LostBird.lookup(search_params).records.to_a
  end

  private

  def lost_bird_params
    params.required(:lost_bird).permit(:status, :name, :address, :bird_id, :lost_at, :found_at, :ring_number, :description)
  end

  def search_params
    params.required(:q).permit(:status, :kind, :ring_number, :description, :address, :date, :for_date, :include_resolved, :meet_all_conditions)
  end
end
