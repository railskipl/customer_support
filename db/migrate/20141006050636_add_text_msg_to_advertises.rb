class AddTextMsgToAdvertises < ActiveRecord::Migration
  def change
    add_column :advertises, :text_msg, :string
  end
end
