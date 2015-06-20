class AddJobsPupsJoinTableForReal < ActiveRecord::Migration
  def change
    create_table :jobs_pups do |t|
      t.integer :pup_id
      t.integer :job_id
    end
  end
end
