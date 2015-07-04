FactoryGirl.define do  

  factory :request do
    status 'shenanigans'
    association :user
  end

end
