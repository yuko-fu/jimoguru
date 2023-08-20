# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    admin { false }
    prefecture { 1 }
    is_valid { true }
  end

  factory :guest_user, class: 'User' do
    sequence(:name) { |n| "GuestUser#{n}" }
    sequence(:email) { |n| "guest_user#{n}@example.com" }
    password { "guest_password" }
    admin { false }
    prefecture { 1 }
    is_valid { false }
  end
end
