class DropNameTypeFromJobsTable < ActiveRecord::Migration
  def change
    remove_column :jobs, :name
    remove_column :jobs, :job_type
  end
end
