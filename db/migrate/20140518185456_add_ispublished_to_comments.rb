class AddIspublishedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :ispublished, :boolean, default: false
  end
end
