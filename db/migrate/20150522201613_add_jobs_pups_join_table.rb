class AddJobsPupsJoinTable < ActiveRecord::Migration
  def change
    create_table :jobs_pups do |t|
      t.belongs_to :job
      t.belongs_to :pup
    end
  end
end

