class EntriesSerializer < ActiveModel::Serializer
  attributes :title, :body, :sentiments, :labels

  def sentiments
    object.sentiment_list
  end

  def labels
    object.label_list
  end
end
