class Location < ActiveRecord::Base
	validates :title, :town_id, presence: true
	validates :title, :uniqueness => { :scope => :town_id }

	has_many :addresses
	belongs_to :town
	has_many :reviews
	
  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['title LIKE ?', search_condition])
  end

end
