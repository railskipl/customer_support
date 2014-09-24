class ChangeColumnAliasToPreferredAlias < ActiveRecord::Migration
  def change
    remove_column :users, :alias
    add_column :users, :preferred_alias,:string
  end
end
