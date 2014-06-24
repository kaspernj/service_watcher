class Reporter < ActiveRecord::Base
  include PublicActivity::Model
  tracked
  
  has_many :options, :as => :resource, :dependent => :destroy
  has_many :group_reporters, :dependent => :destroy
  has_many :groups, :through => :group_reporters
  has_many :service_reporters, :dependent => :destroy
  has_many :services, :through => :service_reporters
  
  def reporter_plugin
    raise sprintf(_("No plugin has been set for this reporter (%s)."), self.id) if self[:plugin].to_s.strip.length <= 0
    return Service_watcher::Reporter.const_get(Php4r.ucwords(self[:plugin])).new(self.details)
  end
end
