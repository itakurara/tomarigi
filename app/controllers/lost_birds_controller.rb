class LostBirdsController < ApplicationController
  def new
    @lost_bird ||= LostBird.new
  end

  def show
  end

  def create
    @lost_bird = LostBird.new({ address_id: address_id }.merge(lost_bird_params))
    if @lost_bird.save
      redirect_to lost_bird_path(@lost_bird)
    else
      render :new
    end
  end

  private

  def address_id
    Address.find_by(zipcode: zipcode)&.id
  end

  def zipcode
    params.required(:lost_bird).permit(:zipcode)[:zipcode]
  end

  def lost_bird_params
    params.required(:lost_bird).permit(:name, :bird_id, :lost_at, :found_at, :ring_number, :description)
  end
end
