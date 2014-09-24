class RenameAcceptsTAndC < ActiveRecord::Migration
  def change
    remove_column :users, :accpect_t_and_c
    add_column :users, :accept_t_and_c, :boolean , default: false
  end
end
