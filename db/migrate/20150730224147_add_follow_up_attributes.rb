class AddFollowUpAttributes < ActiveRecord::Migration
  def change
    add_column :jobs, :how_did_it_go, :string
    add_column :jobs, :actual_walker, :string
    add_column :jobs, :status, :string    

    add_column :users, :awesome_count, :integer
    add_column :users, :not_good_count, :integer
    add_column :users, :no_show_count, :integer
    add_column :users, :walks_completed, :integer    

    add_column :pups, :walks_completed, :integer
      
    remove_column :pups, :aggressive
    remove_column :pups, :chase_prone
    remove_column :pups, :sociable
    remove_column :pups, :curious_fearless
    remove_column :pups, :playful
    
    remove_column :users, :referral_quote
    remove_column :users, :referral_email
    remove_column :users, :referral_first
    remove_column :users, :referral_last
    remove_column :users, :referral_relationship
  end
end
