FactoryGirl.define do

  factory :user do
    confirmed_at Time.now

    factory :pup_owner do
      email 'brntsllvn@gmail.com'
      password 'lalalala'
    end

    factory :walker do
      email 'nvllstnrb@gmail.com'
      password 'lalalala'      
    end
  end

  factory :job do
    drop_off_time DateTime.now
    drop_off_location 'Your desk in Ruby'
    pick_up_time DateTime.now + 1.hour
    pick_up_location 'My desk in Dawson'
    walker_id nil
    walk_request_pending_user_id nil
    # association :user, factory: :user
  end

end
