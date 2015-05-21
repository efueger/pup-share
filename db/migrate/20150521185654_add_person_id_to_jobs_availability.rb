class AddPersonIdToJobsAvailability < ActiveRecord::Migration
  def change
    add_column :jobs, :person_id, :string
    add_index  :jobs, :person_id
    add_column :availabilities, :person_id, :string
    add_index  :availabilities, :person_id
  end
end
