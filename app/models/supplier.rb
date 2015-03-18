class Supplier < ActiveRecord::Base
	has_many :comments

   scope :registered, -> { where(subscription: "Registered") }
   scope :un_registered, -> { where(subscription: "Not Registered") }

  def full_name
    full_name = self.first_name ? self.first_name : ''
    full_name += " " if self.first_name
    full_name += self.try(:last_name)
  end

  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['first_name LIKE ? OR last_name LIKE? or supplier_name LIKE ? OR fname2 LIKE ? OR lname2 LIKE ? OR fname3 LIKE ? OR lname3 LIKE ?', search_condition, search_condition,search_condition,search_condition, search_condition,search_condition,search_condition])
  end

end
