class AddArchiveAndIspublishedToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :archive, :boolean, default: false
    add_column :reviews, :ispublished, :boolean, default: false
  end
end
