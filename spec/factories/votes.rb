FactoryBot.define do
  factory :vote do
    association :shop
    association :user
    association :menu
    content { "Great menu!" }
  end
end
