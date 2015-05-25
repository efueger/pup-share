class AddJobRequestAndConfirmCols < ActiveRecord::Migration
  def change
    add_column :jobs, :walk_request_pending,   :boolean
    add_column :jobs, :walk_request_confirmed, :boolean
    add_column :jobs, :walker_id,              :integer
  end
end
