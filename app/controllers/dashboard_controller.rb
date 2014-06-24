class DashboardController < ApplicationController
  def index
  end
  
private
  
  helper_method :failed_services
  def failed_services
    Service.where(:failed => true).order(:name)
  end
end
