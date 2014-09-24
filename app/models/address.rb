class Address < ActiveRecord::Base
  validate  :company_id, :location_id, :town_id, presence: true
  belongs_to :company
	belongs_to :location
  belongs_to :town
end
