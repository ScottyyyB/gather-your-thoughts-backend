class ThoughtsSerializer < ActiveModel::Serializer
  attributes :title, :body, :sentiment_list, :label_list
end
