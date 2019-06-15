class LostBird < ApplicationRecord
  belongs_to :bird
  belongs_to :address

  before_save :normalize_blank

  def normalize_blank
    attributes.each do |column, _value|
      self[column] = self[column].presence
    end
  end
end
