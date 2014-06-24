class ReportersController < ApplicationController
  before_filter :set_and_authorize
  
  def new
    if params[:reporter]
      @reporter = Reporter.new(reporter_params)
    else
      @reporter = Reporter.new
    end
  end
  
  def create
    @reporter = Reporter.new(reporter_params)
    
    if @reporter.save
      redirect_to @reporter
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @reporter.update_attributes(reporter_params)
      redirect_to @reporter
    else
      render :edit
    end
  end
  
  def destroy
    if @reporter.destroy
      redirect_to @reporter
    else
      redirect_to dashboard_index_path
    end
  end
  
private
  
  def reporter_params
    params.require(:reporter).permit(:name)
  end
end
