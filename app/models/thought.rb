class Thought < ApplicationRecord
  acts_as_taggable_on :labels
  validates :title, :body, presence: true
end
