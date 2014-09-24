class ResourceType < ActiveRecord::Base
	has_many :resources
	extend FriendlyId
  friendly_id :name, use: :slugged
end
