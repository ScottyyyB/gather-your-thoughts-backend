class Entry < ApplicationRecord
  acts_as_taggable_on :labels, :sentiments
  validates :title, :body, :label_list, :sentiment_list, presence: true
  belongs_to :user
end
