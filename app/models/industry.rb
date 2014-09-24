class Industry < ActiveRecord::Base
	validates :title, presence: true, uniqueness: true
	has_many :companies
	has_many :reviews
end
