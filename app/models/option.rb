class Option < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  
  validates_presence_of :resource, :key
  
  def self.options_for_resource(resource)
    result = {}
    Option.where(:resource => resource).each do |option|
      result[option.key] = option.value
    end
    
    return result
  end
end
