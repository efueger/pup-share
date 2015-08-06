class AddWalkLengthParam < ActiveRecord::Migration
  def change
    add_column :jobs, :walk_duration, :integer
  end
end
