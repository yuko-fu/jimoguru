FactoryBot.define do
  factory :user do
    name { "一般ユーザ" }
    email { "user@example.com" }
    password { "user123" }
    password_confirmation { "user123" }
    admin { false }
    prefecture { 1 }
    is_valid { true }
  end
  factory :second_user, class: 'User' do
    name { "一般ユーザ2" }
    email { "second_user@example.com" }
    password { "second_user" }
    password_confirmation { "second_user" }
    admin { false }
    prefecture { 1 }
    is_valid { false }
  end

  factory :admin_user, class: 'User' do
    name { "管理者ユーザ" }
    email { "admin@example.com" }
    password { "admin_password" }
    password_confirmation { "admin_password" }
    admin { true } 
    prefecture { 1 }
    is_valid { false }
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
