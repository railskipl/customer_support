class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
    	t.references  :town
    	t.references  :location
    	t.references  :company
      t.timestamps
    end
  end
end
