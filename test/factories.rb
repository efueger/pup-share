FactoryGirl.define do  

  factory :user do
    sequence(:email) { |n| "email#{n}@factory.com" }
    password 'lalalala'
    password_confirmation 'lalalala'
    confirmed_at Time.now
  end

  factory :job do
    drop_off_time DateTime.now
    drop_off_location 'Your desk in Ruby'
    pick_up_time DateTime.now + 1.hour
    pick_up_location 'My desk in Dawson'
    walker_id nil
    walk_request_pending_user_id nil
    association :user
    association :pup
  end

  factory :pup do
    pup_name 'Ace'
    pup_breed 'Labrador Retriever'
    pup_weight 65
    pup_gender 'Male'
    pup_vet_phone 555-555-5555
    pup_care_instructions 'Watch out! He\'s a jumper'
    pup_age 3
    association :user
  end

  factory :pre_approved_job, parent: :job do
    association :walk_request_pending_user, factory: :user
  end

  factory :approved_job, parent: :job do
    association :walker, factory: :user
  end

  factory :image do
    description 'default image'
    logo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app', 'assets', 'images', 'fallback', 'pup_walk.png')) }
  end

end
