include ActionDispatch::TestProcess

FactoryGirl.define do  

  factory :user do
    sequence(:email) { |n| "email#{n}@factory.com" }
    first_name Faker::Name.first_name
    password 'lalalala'
    password_confirmation 'lalalala'
    confirmed_at Time.now
    pic { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'pup.jpg')) }
  end

end