require 'faker'

FactoryGirl.define do  

  factory :user do
    sequence(:email) { |n| "email#{n}@factory.com" }
    first_name Faker::Name.first_name
    password 'lalalala'
    password_confirmation 'lalalala'
    confirmed_at Time.now
  end

end