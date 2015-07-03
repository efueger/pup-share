FactoryGirl.define do  

  factory :pre_approved_job, parent: :job do
    association :walk_request_pending_user, factory: :user
  end

  factory :approved_job, parent: :job do
    association :walker, factory: :user
  end

end
