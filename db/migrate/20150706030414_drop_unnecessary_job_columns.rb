class DropUnnecessaryJobColumns < ActiveRecord::Migration
  def change
    remove_column :jobs, :walker_id
    remove_column :jobs, :walk_request_pending_user_id
  end
end
