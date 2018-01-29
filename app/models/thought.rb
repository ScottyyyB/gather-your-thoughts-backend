class Thought < ApplicationRecord
  acts_as_taggable_on :labels, :sentiments
  validates :title, :body, presence: true
end
