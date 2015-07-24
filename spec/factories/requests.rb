FactoryGirl.define do  

  factory :request do
    status Faker::Lorem.word
    association :user
  end

end
