class CheckAllServicesCommand
  def self.execute
    Service.where(:active => true).each do |service|
      service.check
    end
  end
end
