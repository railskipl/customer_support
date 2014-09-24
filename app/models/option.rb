class Option < ActiveRecord::Base
	belongs_to :poll
	has_many :results
end
