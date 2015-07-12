class FacilitateJobsAvailabilitiesAssoc < ActiveRecord::Migration
  def change
    add_column :availabilities, :job_id, :integer
    add_column :jobs, :availability_id, :integer
  end
end
