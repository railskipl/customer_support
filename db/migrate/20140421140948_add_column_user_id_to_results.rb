class AddColumnUserIdToResults < ActiveRecord::Migration
  def change
    add_column :results, :user_id, :integer
  end
end
