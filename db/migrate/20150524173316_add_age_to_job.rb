class AddAgeToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :pup_age, :integer
  end
end
