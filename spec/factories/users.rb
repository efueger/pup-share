include ActionDispatch::TestProcess

FactoryGirl.define do  

  factory :user do
    sequence(:email) { |n| "email#{n}@gmail.com" }
    first_name Faker::Name.first_name
    password 'lalalala'
    password_confirmation 'lalalala'
    confirmed_at Time.now
    # causes one file to be uploaded for every user created...
    # need a trash clean up for this...
    # committing 11,000+ pics to git probably not a good idea...
    # pic { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'pup.jpg')) }
    
  end

end