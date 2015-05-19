class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :job_type
      t.datetime :drop_off_time
      t.string :drop_off_location
      t.datetime :pick_up_time
      t.string :pick_up_location

      t.timestamps null: false
    end
  end
end
