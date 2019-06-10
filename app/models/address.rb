class Address < ApplicationRecord
  has_many :lost_birds, dependent: :restrict_with_exception
end
