class CompanyPerformance < ActiveRecord::Base

	belongs_to :user
	mount_uploader :performance_img, ImageUploader
	mount_uploader :best_performance, ImageUploader
end
