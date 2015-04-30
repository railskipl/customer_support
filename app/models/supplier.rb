class Supplier < ActiveRecord::Base
	has_many :comments

   scope :registered, -> { where("subscription != ?","Not Registered") }
   scope :un_registered, -> { where(subscription: "Not Registered") }
   scope :by_industry, -> (industry) { where("industry = ?", industry)  unless industry.blank? }
   scope :by_company, -> (company) { where("supplier_name = ?", company) unless company.blank? }
   scope :within_range , -> (start_date, end_date) { where("created_at >= ? AND created_at <= ?", start_date, end_date) unless start_date.blank? and end_date.blank? }
  
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
