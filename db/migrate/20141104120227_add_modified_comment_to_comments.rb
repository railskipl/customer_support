class AddModifiedCommentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :modified_comment, :text
  end
end
