class RemovePupStuffFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :pup_name
    remove_column :users, :pup_breed
    remove_column :users, :pup_weight
    remove_column :users, :pup_gender
    remove_column :users, :pup_bday
    remove_column :users, :pup_vet_phone
    remove_column :users, :pup_care_instructions
    
    add_column    :jobs, :pup_name,              :string
    add_column    :jobs, :pup_breed,             :string
    add_column    :jobs, :pup_weight,            :string
    add_column    :jobs, :pup_gender,            :string
    add_column    :jobs, :pup_bday,              :date
    add_column    :jobs, :pup_vet_phone,         :string
    add_column    :jobs, :pup_care_instructions, :text
  end
end
