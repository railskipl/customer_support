class Review < ActiveRecord::Base
  belongs_to :company
  belongs_to :industry
  belongs_to :location
  belongs_to :town
  belongs_to :user
  has_many   :comments
  validate :valid_date?
  validate :industry_id, :company_id, :town_id, :location_id ,presence: true

  scope :published, -> { where(ispublished: true).order(date: :desc) }
  scope :archived, -> { where(archive: true) }
  scope :unarchived, -> { where(archive: false) }
  scope :unpublished, -> { where(ispublished: false) }
  scope :within_range, -> (start_date, end_date) { where("created_at >= ? AND created_at <= ?", start_date, end_date) unless start_date.blank? and end_date.blank? }
  scope :by_industry, -> (industry_id) { where("industry_id = ?", industry_id)  unless industry_id.blank? }
  scope :by_town, -> (town_id) { where("town_id = ?", town_id) unless town_id.blank? }
  scope :by_company, -> (company_id) { where("company_id = ?", company_id) unless company_id.blank? }
  scope :by_location, -> (location_id) { where("location_id = ?", location_id)  unless location_id.blank? }
  scope :by_review_type, -> (review_type) { where("review_type = ?", review_type) unless review_type.blank? }

  attr_accessor :from_date, :to_date
	
  mount_uploader :file, PdfUploader

  before_create :generate_ticket_number
  before_update :update_conversion_date
	
  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ["(title LIKE ? OR message LIKE ? OR review_type LIKE ? OR ticket_number LIKE ? ) && ispublished = true", search_condition, search_condition,search_condition,search_condition])
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
end
