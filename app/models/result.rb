class Result < ActiveRecord::Base
  belongs_to :poll
  belongs_to :option
  belongs_to :user

 validates :option_id, :presence => true
end
