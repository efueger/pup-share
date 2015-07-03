require 'rails_helper'

RSpec.describe "requests/index", type: :view do
  before(:each) do
    assign(:requests, [
      Request.create!(
        :requested_by_user_id => 1,
        :requested_of_user_id => 2,
        :status => "Status",
        :job_id => 3,
        :availability_id => 4
      ),
      Request.create!(
        :requested_by_user_id => 1,
        :requested_of_user_id => 2,
        :status => "Status",
        :job_id => 3,
        :availability_id => 4
      )
    ])
  end

  it "renders a list of requests" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
