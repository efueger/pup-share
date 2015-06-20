class WhoopsSimplerAssocationBetweenPupAndJobDropJoinTable < ActiveRecord::Migration
  def change
    drop_table :jobs_pups
    remove_column :pups, :job_id
  end
end
