class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :telephone
      t.string :message_type
      t.text :message

      t.timestamps
    end
  end
end
