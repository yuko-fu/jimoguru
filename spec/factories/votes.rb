FactoryBot.define do
  factory :vote do
    association :shop
    association :user
    association :menu
    content { "Great!" }
  end
end
