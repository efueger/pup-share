class AddPupIdToJob < ActiveRecord::Migration
  def change
    add_column :pups, :job_id, :integer
    add_index  :pups, :job_id
  end
end
