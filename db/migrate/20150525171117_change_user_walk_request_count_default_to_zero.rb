class ChangeUserWalkRequestCountDefaultToZero < ActiveRecord::Migration
  def change
    change_column :users, :user_pending_requests_count, :integer, default: 0
  end
end
