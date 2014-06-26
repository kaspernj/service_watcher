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
    
    begin
      Timeout.timeout(timeout || 60) do
        plugin.plugin_class.check(args)
      end
      
      set_up_again
      create_activity :key => "service.check.successful"
      return true
    rescue => e
      set_failed(e)
      create_activity :key => "service.check.unsuccessful", :parameters => {:message => e.message, :backtrace => e.backtrace}
      return false
    end
  end
  
private
  
  def set_failed(error)
    return if failed?
    
    update_attribute(:failed, true)
    
    group.reporters.each do |reporter|
      reporter.report_failed(
        :service => self,
        :error => error
      )
    end
  end
  
  def set_up_again
    return unless failed?
    
    update_attribute(:failed, false) if failed?
    
    group.reporters.each do |reporter|
      reporter.report_up_again(
        :service => self
      )
    end
  end
end
