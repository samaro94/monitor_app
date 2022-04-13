class ServiceBlock < ApplicationRecord
  belongs_to :service

  validates_uniqueness_of :week_day, scope: :service_id
end
