FactoryBot.define do
  factory :label1 ,class: Label do
    id { 1 }
    name { 'A' }
    user_id { nil }
  end

  factory :label2, class: Label do
    id { 2 }
    name { 'B' }
    user_id { nil }
  end
end
