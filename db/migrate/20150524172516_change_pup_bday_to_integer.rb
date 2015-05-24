class ChangePupBdayToInteger < ActiveRecord::Migration
  def change
    remove_column :jobs, :pup_bday
  end
end
