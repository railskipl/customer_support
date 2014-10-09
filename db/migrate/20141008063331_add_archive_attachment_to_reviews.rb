class AddArchiveAttachmentToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :archive_attachment, :boolean,:default => false
  end
end
