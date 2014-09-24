class Poll < ActiveRecord::Base
	has_many :options
	has_many :results, through: :options

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  accepts_nested_attributes_for :options, :reject_if => lambda { |a| a[:answer].blank? }
  
end
