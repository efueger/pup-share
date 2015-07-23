FactoryGirl.define do  

  factory :job do
    drop_off_time Time.now
    drop_off_location Faker::Name.first_name
    pick_up_time Time.now + 1.hour
    pick_up_location Faker::Name.first_name

    association :user
    association :pup

    factory :invalid_job do
      drop_off_time nil
    end

  end

end