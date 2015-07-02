FactoryGirl.define do  

  factory :availability do
    available_from Time.now
    available_to Time.now + 1.hour
    location 'My desk in Ruby'
    comment 'No dogs bigger than 200lbs!'
    association :user

    factory :invalid_availability do
      available_from nil
    end

  end

end

