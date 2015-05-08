class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:async, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable

  has_many :reviews
  has_many :results
  has_many :replies, :through => :reviews, :source => :comments
  has_many :comments
  has_many :seos
  has_many :abuse_reports
  has_many :track_times
  
  has_many :agent_notifications, :class_name => "Notification", :foreign_key => 'receiver_agent_id'
  has_many :jagent_notifications, :class_name => "Notification", :foreign_key => 'receiver_jagent_id'
  
  before_save :title_case_name
  validates :preferred_alias, uniqueness: {message: " is already taken. Please input another alias name.", case_sensitive: false }
  validates :password, confirmation: true
  validates :first_name, :last_name, length: { maximum: 35 }
  validates :preferred_alias, length: { maximum: 20 }
  validates :address_line1,:address_line2, length: { maximum: 254 }
  validate  :valid_dob
  mount_uploader :avatar, ImageUploader


  scope :customers, -> { where(role: 'user') }
  scope :agents, -> { where("role = ? or role = ?","agent","jagent") }
  scope :admins, -> { where(role: 'admin') }

  def full_name
    full_name = self.first_name ? self.first_name : ''
    full_name += " " if self.first_name
    full_name += self.try(:last_name)
  end


   def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['first_name LIKE ? OR last_name LIKE ? OR email LIKE ? ', search_condition,search_condition,search_condition])
  end

  def is_admin?
  	self.role == 'admin'
  end

  def is_agent?
  	self.role == 'agent'
  end

  def is_jagent?
    self.role == 'jagent'
  end

  def is_customer?
  	!is_admin? && !is_agent?
  end

  def compliments
  	self.reviews.by_review_type(:compliment) 
  end

  def complaints
  	self.reviews.by_review_type(:complaint) 
  end

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def valid_dob
    if User.current.present?
      if User.current.role == 'admin' || User.current.role == 'agent'
        is_user = false
      end
    end
    if is_user
      unless Chronic.parse(dob)
        errors.add(:dob, "is invalid!")
      end
    end
  end

  def title_case_name
    self.first_name = self.first_name.titlecase
    self.last_name = self.last_name.titlecase
  end

  def assigned_role
    self.role
  end

  def country_name
    country = ISO3166::Country[country]
    country.translations[I18n.locale.to_s] || country.name
  end

  def is?( requested_role )
    self.role == requested_role.to_s
  end
end