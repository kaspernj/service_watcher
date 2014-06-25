class DashboardController < ApplicationController
  def index
  end
  
  def check_all
    CheckAllServicesCommand.execute
    redirect_to dashboard_index_path
  end
  
private
  
  helper_method :failed_services
  def failed_services
    Service.where(:failed => true).order(:name)
  end
end
