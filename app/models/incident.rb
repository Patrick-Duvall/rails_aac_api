class Incident < ApplicationRecord
  has_many :incident_tags
  has_many :tags, through: :incident_tags
end
