FactoryGirl.define do  
  
  factory :user do
    sequence(:email) { |n| "email#{n}@factory.com" }
    password 'lalalala'
    confirmed_at Time.now
  end
  
  factory :pup do
    
  end
  
  factory :job do
    drop_off_time DateTime.now
    drop_off_location 'Your desk in Ruby'
    pick_up_time DateTime.now + 1.hour
    pick_up_location 'My desk in Dawson'
    walker_id nil
    walk_request_pending_user_id nil
    association :user
  end

  factory :pre_approved_job, parent: :job do
    association :walk_request_pending_user, factory: :user
  end
  
  factory :approved_job, parent: :job do
    association :walker, factory: :user
  end
  
end
