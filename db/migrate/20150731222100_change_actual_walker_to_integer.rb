class ChangeActualWalkerToInteger < ActiveRecord::Migration
  def change
    remove_column :jobs, :actual_walker
    add_column :jobs, :actual_walker_id, :integer
  end
end
