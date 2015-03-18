class Company < ActiveRecord::Base
	validates :title, presence: true, uniqueness: true
	belongs_to :industry
	has_many :addresses
	has_many :towns, through: :addresses
	has_many :reviews

  # scope :registered, -> { where(is_registered: true) }
  # scope :un_registered, -> { where(is_registered: false) }

  scope :within_range , -> (start_date, end_date) { where("created_at >= ? AND created_at <= ?", start_date, end_date) unless start_date.blank? and end_date.blank? }
  scope :by_industry, -> (industry_id) { where("industry_id = ?", industry_id)  unless industry_id.blank? }
  scope :by_town, -> (town_id) { where("town_id = ?", town_id) unless town_id.blank? }
  scope :by_company, -> (company_id) { where("id = ?", company_id) unless company_id.blank? }


  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['title LIKE ?', search_condition])
  end

  def is_registered?
  	is_registered
  end

  def is_not_registered?
  	!is_registered
  end

end
