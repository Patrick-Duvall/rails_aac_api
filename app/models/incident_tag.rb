class IncidentTag < ApplicationRecord
  belongs_to :tag
  belongs_to :incident
end
