require 'rails_helper'

RSpec.describe "requests/new", type: :view do
  before(:each) do
    assign(:request, Request.new(
      :requested_by_user_id => 1,
      :requested_of_user_id => 1,
      :status => "MyString",
      :job_id => 1,
      :availability_id => 1
    ))
  end

  it "renders new request form" do
    render

    assert_select "form[action=?][method=?]", requests_path, "post" do

      assert_select "input#request_requested_by_user_id[name=?]", "request[requested_by_user_id]"

      assert_select "input#request_requested_of_user_id[name=?]", "request[requested_of_user_id]"

      assert_select "input#request_status[name=?]", "request[status]"

      assert_select "input#request_job_id[name=?]", "request[job_id]"

      assert_select "input#request_availability_id[name=?]", "request[availability_id]"
    end
  end
end
