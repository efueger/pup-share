FactoryGirl.define do  

  factory :job do
    drop_off_time Time.now
    sequence(:drop_off_location) { |n| "#{Faker::Name.first_name}_#{n}" }
    walk_duration 15
    pick_up_location Faker::Name.first_name
    pick_up_time Time.now + 15 * 60
    
    association :user
    association :pup

    factory :invalid_job do
      pup_id nil
    end

  end

end