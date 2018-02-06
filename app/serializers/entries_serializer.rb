class EntriesSerializer < ActiveModel::Serializer
  attributes :title, :body, :sentiments, :labels, :date

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
