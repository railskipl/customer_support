class AddAdminSagentModifiedToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :admin_sagent_modified, :boolean, :default => false
  end
end
