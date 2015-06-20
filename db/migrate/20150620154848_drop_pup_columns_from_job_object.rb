class DropPupColumnsFromJobObject < ActiveRecord::Migration
  def change

    remove_column :jobs, :pup_name
    remove_column :jobs, :pup_breed
    remove_column :jobs, :pup_weight
    remove_column :jobs, :pup_gender
    remove_column :jobs, :pup_vet_phone
    remove_column :jobs, :pup_care_instructions
    remove_column :jobs, :pup_age
    
  end
end
