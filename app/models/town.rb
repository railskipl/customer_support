class Town < ActiveRecord::Base
	validates :title, presence: true
	has_many :locations
	has_many :reviews
	
  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['title LIKE ?', search_condition])
  end

end
