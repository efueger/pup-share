class DropRedundantJobFields < ActiveRecord::Migration
  def change
    remove_column :jobs, :walk_request_pending
    remove_column :jobs, :walk_request_confirmed
  end
end
