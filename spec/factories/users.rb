include ActionDispatch::TestProcess

FactoryGirl.define do  

  factory :user do
    sequence(:email) { |n| "email#{n}@amazon.com" }
    first_name Faker::Name.first_name
    password 'lalalala'
    password_confirmation 'lalalala'
    confirmed_at Time.now

    # causes one file to be uploaded for every user created...
    # need a trash clean up for this...
    # committing 11,000+ pics to git probably not a good idea...
    # pic { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'pup.jpg')) }

    factory :invalid_user do
      email "invalid-email@gmail.com"
    end

    factory :walker do
      email "walker@amazon.com"
    end

    factory :pup_owner do
      email "pup-owner@amazon.com"
    end

  end

end