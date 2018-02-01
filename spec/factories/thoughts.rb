FactoryBot.define do
  factory :thought do
    user
    title "MyString"
    body "MyText"
    label_list "Family"
    sentiment_list "Happy"
  end
end
