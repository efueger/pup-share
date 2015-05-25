class AddUserPendingRequestsCount < ActiveRecord::Migration
  def change
    add_column :users, :user_pending_requests_count, :integer
  end
end
