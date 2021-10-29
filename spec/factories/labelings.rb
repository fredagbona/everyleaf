FactoryBot.define do
  factory :labeling1 ,class: Labeling do
    id { 1 }
    task_id { 1 }
    label_id { 1 }
  end

  factory :labeling2, class: Labeling do
    id { 2 }
    task_id { 2 }
    label_id { 1 }
  end
end
