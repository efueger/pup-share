class AddPupIdToJobsTable < ActiveRecord::Migration
  def change
    add_column :jobs, :pup_id, :integer
  end
end
