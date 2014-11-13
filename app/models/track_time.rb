class TrackTime < ActiveRecord::Base
	belongs_to :review
	belongs_to :user
end
