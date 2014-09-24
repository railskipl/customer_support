class Supplier < ActiveRecord::Base
	has_many :comments

  def full_name
    full_name = self.first_name ? self.first_name : ''
    full_name += " " if self.first_name
    full_name += self.try(:last_name)
  end

  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['first_name LIKE ? OR last_name LIKE?', search_condition, search_condition])
  end

end
