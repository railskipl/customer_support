class Review < ActiveRecord::Base
  belongs_to :company
  belongs_to :industry
  belongs_to :location
  belongs_to :town
  belongs_to :user
  belongs_to :jagent, :class_name => "User"
  belongs_to :agent, :class_name => "User"
  belongs_to :old_agent, :class_name => "User"
  belongs_to :old_jagent, :class_name => "User"
  belongs_to :last_published_agent, :class_name => "User"
  has_many   :comments
  has_many :track_times, dependent: :destroy
  has_many :review_notes
  has_one  :monitor_jagent, dependent: :destroy
  validate :valid_date?
  validate :industry_id, :company_id, :town_id, :location_id ,presence: true

  scope :published, -> { where(ispublished: true).order(id: :desc) }
  scope :archived, -> { where(archive: true) }
  scope :unarchived, -> { where(archive: false).order(id: :desc) }
  scope :unpublished, -> { where(ispublished: false).order(id: :desc) }
  scope :within_range, -> (start_date, end_date) { where("Date(created_at) >= ? AND Date(created_at) <= ?", start_date, end_date) unless start_date.blank? and end_date.blank? }
  scope :by_industry, -> (industry_id) { where("industry_id = ?", industry_id)  unless industry_id.blank? }
  scope :by_town, -> (town_id) { where("town_id = ?", town_id) unless town_id.blank? }
  scope :by_company, -> (company_id) { where("company_id = ?", company_id) unless company_id.blank? }
  scope :by_location, -> (location_id) { where("location_id = ?", location_id)  unless location_id.blank? }
  scope :by_review_type, -> (review_type) { where("review_type = ?", review_type) unless review_type.blank? }

  attr_accessor :from_date, :to_date
	
  mount_uploader :file, PdfUploader

  before_create :generate_ticket_number
  before_update :update_conversion_date
	
  def self.junior_agent(id)
    unpublished.unarchived.where("jagent_id = ? and modified_review is null and user_id is not null",id)
  end

  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['(title LIKE ? OR message LIKE ? OR review_type LIKE ? OR ticket_number LIKE ? ) and ispublished = ?', search_condition, search_condition,search_condition,search_condition,true])
  end

  def self.admin_search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['title LIKE ? OR message LIKE ? OR review_type LIKE ? OR ticket_number LIKE ? ', search_condition, search_condition,search_condition,search_condition])
  end

  def valid_date?
    unless Chronic.parse(date)
      errors.add(:date, "is invalid!")
    end
  end

  def generate_ticket_number
   self.ticket_number = ("%013d" % (Review.last ? Review.last.id + 1 : 1).to_s)
  end
  
  def date_time
    self.date.to_s + " " + self.datetime.strftime("%H:%M:%S")
  end
  
  def update_conversion_date
  	if self.review_type_changed?
  		self.change_date = DateTime.now
  	end
  end

  def customer_count
    self.comments.where("supplier_id is null").count
  end
  
  def supplier_count
    self.comments.where("supplier_id is not null").count
  end

  def self.nature_count(nature_type)
    where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  and ispublished = ? and archive = ? ',1.year.ago, Date.today,nature_type,true,false)
  end

  def self.nature_count2(industry_id,nature_type)
    where('Date(created_at) >= ? and Date(created_at) <= ? and industry_id = ? and user_id is not null and nature_of_review = ?  and ispublished = ? and archive = ? ',1.year.ago, Date.today,industry_id,nature_type,true,false)
  end

  def self.nature_count3(company_id,nature_type)
    where('Date(created_at) >= ? and Date(created_at) <= ? and company_id = ? and user_id is not null and nature_of_review = ?  and ispublished = ? and archive = ? ',1.year.ago, Date.today,company_id,nature_type,true,false)
  end

end
