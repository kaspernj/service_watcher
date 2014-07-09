class ServiceReporter < ActiveRecord::Base
  belongs_to :reporter
  belongs_to :service

  validates_presence_of :service, :reporter
  validates_uniqueness_of :reporter, :scope => :service
end
