class Service < ActiveRecord::Base
  include PublicActivity::Model
  tracked
  
  belongs_to :group
  belongs_to :plugin
  
  has_many :options, :as => :resource, :dependent => :destroy
  has_many :service_reporter, :dependent => :destroy
  has_many :reporters, :through => :service_reporterlinks
  
  validates_presence_of :name, :plugin, :group
  
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
  
  def parameters
    parameters = plugin.parameters
    
    parameters.each do |parameter|
      option = options.where(:key => "parameter_#{parameter["name"]}").first
      next unless option
      parameter["value"] = option.value
    end
    
    return parameters
  end
  
  def check
    args = {}
    parameters.each do |parameter|
      args[parameter["name"]] = parameter["value"]
    end
    
    timeout = timeout || 60
    failed = false
    
    begin
      Timeout.timeout timeout do
        plugin.plugin_class.check(args)
      end
    rescue => e
      error = e
      failed = true
      update_attribute(:failed, true) unless failed
      create_activity :key => "service.check.unsuccessful", :parameters => {:message => e.message, :backtrace => e.backtrace}
    end
    
    if failed
      group.reporters.each do |reporter|
        reporter.report(
          :service => self,
          :error => e
        )
      end
      
      return false
    else
      update_attribute(:failed, false) if failed
      create_activity :key => "service.check.successful"
      return true
    end
  end
end
