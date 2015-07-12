class AddJobsAvailabilitiesJoinTable < ActiveRecord::Migration
  def change
    create_table :availabilities_jobs, id: false do |t|
      t.belongs_to :availability, index: true
      t.belongs_to :job, index: true
    end
  end
end
