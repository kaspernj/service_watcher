class Service < ActiveRecord::Base
  has_many :options, :as => :resource, :dependent => :destroy
  has_many :service_reporterlinks, :dependent => :destroy
  has_many :reporters, :through => :service_reporterlinks
  
  belongs_to :group
  
  validates_presence_of :plugin, :group
  
  def reporters_merged
    reporters = []
    self.reporters.each do |link|
      reporters << link.reporter
    end
    
    if self.group
      self.group.reporters.each do |link|
        if reporters.index(link.reporter) == nil
          reporters << link.reporter
        end
      end
    end
    
    return reporters
  end
  
  def plugin_class
    raise _("No plugin set for this service.") if self[:plugin].to_s.length <= 0
    return Service_watcher::Plugin.const_get(Php4r.ucwords(self[:plugin]))
  end
  
  def check
    self.plugin_class.check(self.details)
  end
end
