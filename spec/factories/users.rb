FactoryBot.define do
  factory :user do
    name { "一般ユーザ" }
    email { "user@example.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
    admin { false }
    prefecture { 1 }
    is_valid { true }
  end

  factory :admin_user, class: 'User' do
    name { "管理者ユーザ" }
    email { "admin@example.com" }
    password { "admin_password" }
    password_confirmation { "admin_password" }
    admin { true } 
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
