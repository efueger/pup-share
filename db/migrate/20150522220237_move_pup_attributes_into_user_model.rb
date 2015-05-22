class MovePupAttributesIntoUserModel < ActiveRecord::Migration
  def change
    add_column :users, :pup_name, :string
    add_column :users, :pup_breed, :string
    add_column :users, :pup_weight, :integer
    add_column :users, :pup_gender, :boolean
    add_column :users, :pup_bday, :date
    add_column :users, :pup_vet_phone, :string
    add_column :users, :pup_care_instructions, :text
  end
end
