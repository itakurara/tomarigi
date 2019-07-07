class Comment < ApplicationRecord
  belongs_to :lost_bird
  belongs_to :user
  validates :content, presence: true
end
