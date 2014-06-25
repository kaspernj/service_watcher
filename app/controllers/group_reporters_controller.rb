class GroupReportersController < ApplicationController
  before_filter :set_group
  before_filter :set_and_authorize
  
  def new
    @group_reporter = @group.group_reporters.new(group_reporter_params)
  end
  
  def create
    @group_reporter = @group.group_reporters.new(group_reporter_params)
    
    if @group_reporter.save
      redirect_to @group_reporter.group
    else
      flash[:error] = @group_reporter.errors.full_messages.join(". ")
      render :new
    end
  end
  
  def destroy
    unless @group_reporter.destroy
      flash[:error] = @group_reporter.errors.full_messages.join(". ")
    end
    
    redirect_to @group_reporter.group
  end
  
private
  
  def set_group
    @group = Group.find(params[:group_id])
    authorize! :edit, @group
  end
  
  def group_reporter_params
    params.require(:group_reporter).permit(:reporter_id)
  end
  
  helper_method :reporter_collection
  def reporter_collection
    reporter_ids = @group.reporters.map{ |reporter| reporter.id } + [0]
    
    Reporter.where("id NOT IN (?)", reporter_ids).order(:name)
  end
end
