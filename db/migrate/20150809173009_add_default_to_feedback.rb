class AddDefaultToFeedback < ActiveRecord::Migration
  def change
    change_column_default :users, :feedback_rating, 0
  end
end
