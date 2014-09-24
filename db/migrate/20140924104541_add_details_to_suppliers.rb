class AddDetailsToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :auth_resp2, :string
    add_column :suppliers, :title2, :string
    add_column :suppliers, :fname2, :string
    add_column :suppliers, :lname2, :string
    add_column :suppliers, :email2, :string
    add_column :suppliers, :tno2, :string
    add_column :suppliers, :mno2, :string
    add_column :suppliers, :auth_resp3, :string
    add_column :suppliers, :title3, :string
    add_column :suppliers, :fname3, :string
    add_column :suppliers, :lname3, :string
    add_column :suppliers, :email3, :string
    add_column :suppliers, :tno3, :string
    add_column :suppliers, :mno3, :string
    add_column :suppliers, :notes, :text
  end
end
