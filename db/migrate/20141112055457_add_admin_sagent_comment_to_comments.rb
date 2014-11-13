class AddAdminSagentCommentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :admin_sagent_comment, :boolean, :default => false
  end
end
