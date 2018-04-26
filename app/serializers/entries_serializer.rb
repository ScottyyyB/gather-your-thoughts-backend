class EntriesSerializer < ActiveModel::Serializer
  attributes :title, :body, :sentiments, :labels, :created_at

  def sentiments
    object.sentiment_list
  end

  def labels
    object.label_list
  end

  def date
    Date.parse(object.created_at.to_s)
  end
end
