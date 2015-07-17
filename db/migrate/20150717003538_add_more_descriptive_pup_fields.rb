class AddMoreDescriptivePupFields < ActiveRecord::Migration
  def change
    add_column :pups,  :special_needs, :boolean
    add_column :pups,  :playful, :boolean
    add_column :pups,  :curious_fearless, :boolean
    add_column :pups,  :sociable, :boolean
    add_column :pups,  :chase_prone, :boolean
    add_column :pups,  :aggressive, :boolean
    add_column :pups,  :spayed_neutered, :boolean
    add_column :users, :pups_w_special_needs, :boolean
    add_column :availabilities, :walk_type, :string
    add_column :users, :walking_experience, :text
    add_column :users, :small_pups, :boolean
    add_column :users, :medium_pups, :boolean
    add_column :users, :large_pups, :boolean
    add_column :users, :giant_pups, :boolean
    add_column :users, :oral_med_admin, :boolean
    add_column :users, :senior_pups, :boolean
    add_column :users, :puppies, :boolean
    add_column :users, :bathroom_breaks, :boolean
    add_column :users, :referral_quote, :text
    add_column :users, :referral_email, :string
    add_column :users, :referral_first, :string 
    add_column :users, :referral_last, :string 
    add_column :users, :referral_relationship, :string
  end
end
