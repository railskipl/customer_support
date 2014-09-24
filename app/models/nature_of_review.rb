class NatureOfReview < ActiveRecord::Base
	validates :title,:review_type, :presence=>true
end
