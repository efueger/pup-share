class AddJobIdToPupModel < ActiveRecord::Migration
  def change
    add_column :pups, :job_id, :integer
  end
end
