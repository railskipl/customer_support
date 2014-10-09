class CompanyPerformance < ActiveRecord::Base

	belongs_to :user
	mount_uploader :performance_img, ImageUploader
end
