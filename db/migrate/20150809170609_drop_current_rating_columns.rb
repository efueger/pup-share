class DropCurrentRatingColumns < ActiveRecord::Migration
  def change
    remove_column :users, :awesome_count
    remove_column :users, :not_good_count
    remove_column :users, :no_show_count
    add_column :users, :feedback_rating, :float
  end
end
