FactoryBot.define do
  factory :task do
    name {'Name low'}
    description {'Description low'}
    expiration_date {DateTime.now + 1.day}
    status {0}
    priority {0}
    
  end

  factory :ndtask, class: Task do
    name {'Name high'}
    description {'Description high'}
    expiration_date {DateTime.now + 6.day}
    status {1}
    priority {1}
   
  end

  factory :thrdtask, class: Task do
    name {'Name hl'}
    description {'Description hl'}
    expiration_date {DateTime.now + 8.day}
    status {2}
    priority {2}
    
  end

  
end
