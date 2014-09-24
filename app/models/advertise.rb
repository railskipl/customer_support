class Advertise < ActiveRecord::Base
	mount_uploader :image, ImageUploader
end
