module LostBirdsHelper
  def options_for_status
    LostBird.statuses.map { |k, v| [LostBird.human_attribute_name("status.#{k}"), k] }
  end

  def options_for_birds
    Bird.all.map { |b| [b.ja_name, b.id] }
  end
end
