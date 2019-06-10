class LostBird < ApplicationRecord
  belongs_to :bird
  belongs_to :address
end
