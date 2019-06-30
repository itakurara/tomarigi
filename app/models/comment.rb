class Comment < ApplicationRecord
  belongs_to :lost_bird
  validates :content, presence: true
end
