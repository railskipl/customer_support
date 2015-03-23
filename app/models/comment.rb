class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  belongs_to :supplier
  has_one :notification
  validates :title, presence: true
  scope :published, -> { where(ispublished: true) }
  scope :supplier_comments, -> { where("supplier_id is NOT NULL") }
  
  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['title LIKE ? OR name LIKE ?', search_condition, search_condition])
  end
  
end
