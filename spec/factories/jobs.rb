FactoryGirl.define do  

  factory :job do
    drop_off_time Time.now
    drop_off_location 'Ruby'
    pick_up_time Time.now + 1.hour
    pick_up_location 'Dawson'

    association :user
    association :pup

    factory :invalid_job do
      drop_off_time nil
    end

  end

end