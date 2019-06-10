class Bird < ApplicationRecord
  has_many :lost_birds, dependent: :nullify
  validates :ja_name, presence: true
end
