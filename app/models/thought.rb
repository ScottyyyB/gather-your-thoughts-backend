class Thought < ApplicationRecord
  validates :title, :body, presence: true
end
