class Reporter < ActiveRecord::Base
  include PublicActivity::Model
  tracked
  
  belongs_to :reporter_plugin
  
  has_many :options, :as => :resource, :dependent => :destroy, :autosave => true
  has_many :group_reporters, :dependent => :destroy
  has_many :groups, :through => :group_reporters
  has_many :service_reporters, :dependent => :destroy
  has_many :services, :through => :service_reporters
  
  validates_presence_of :name, :reporter_plugin
  
  def parameters
    parameters = reporter_plugin.parameters
    
    parameters.each do |parameter|
      option = options.where(:key => "parameter_#{parameter["name"]}").first
      next unless option
      parameter["value"] = option.value
    end
    
    return parameters
  end
  
  def report(args)
    plugin_args = {}
    parameters.each do |parameter|
      plugin_args[parameter["name"]] = parameter["value"]
    end
    
    reporter_plugin.plugin_class.report(:reporter => self, :service => args[:service], :args => plugin_args)
  end
end
