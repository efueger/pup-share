class AddWalkRequestPendingUserId < ActiveRecord::Migration
  def change
    add_column :jobs, :walk_request_pending_user_id, :integer
  end
end
