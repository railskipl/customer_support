class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :alias, :string
    add_column :users, :gender, :string
    add_column :users, :age, :string
    add_column :users, :dob, :date
    add_column :users, :country, :string
    add_column :users, :pobox, :string
    add_column :users, :postal_code, :integer
    add_column :users, :town, :string
    add_column :users, :lives_in, :string
    # add_column :users, :secret_question, :string
    # add_column :users, :answer, :string
    add_column :users, :accpect_t_and_c, :boolean
  end
end
