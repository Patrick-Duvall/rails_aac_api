class Tag < ApplicationRecord
  has_many :incident_tags
  has_many :incidents, through: :incident_tags
end
