class LostBirdsController < ApplicationController
  def new
    @lost_bird = LostBird.new
  end
end
