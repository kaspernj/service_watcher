class GroupReporter < ActiveRecord::Base
  belongs_to :group
  belongs_to :reporter

  validates_presence_of :group, :reporter
  validates_uniqueness_of :reporter, :scope => :group
end
