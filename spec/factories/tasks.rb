FactoryBot.define do
  factory :task do
    name {'Name low'}
    description {'Description low'}
    expiration_date {DateTime.now + 1.day}
    status {'unstarted'}
  end

  factory :ndtask, class: Task do
    name {'Name high'}
    description {'Description high'}
    expiration_date {DateTime.now + 6.day}
    status {'progress'}
  end

  
end
