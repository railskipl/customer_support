class AddColumnAddressLine1AndAddressLine2Users < ActiveRecord::Migration
  def change
	  add_column :users, :address_line1, :string
    add_column :users, :address_line2, :string
  end
end
