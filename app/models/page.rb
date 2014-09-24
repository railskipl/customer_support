class Page < ActiveRecord::Base
	validates :name, :title, :slug ,:presence => true
	validates :slug ,:uniqueness => true
end
