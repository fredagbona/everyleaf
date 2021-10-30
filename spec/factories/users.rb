FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'user' }
    email { 'user@example.com' }
    password { '00000000' }
    admin { false }
  end
  factory :admin_user, class: User do
    id { 3 }
    name { 'admin' }
    email { 'admin@example.com' }
    password { '00000000' }
    admin { true }
  end
end
