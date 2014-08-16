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
    set_parameters

    if @reporter.save
      redirect_to ["edit", @reporter]
    else
      render :new
    end
  end

  def edit
  end

  def update
    set_parameters

    if @reporter.update_attributes(reporter_params)
      redirect_to @reporter
    else
      render :edit
    end
  end

  def destroy
    if @reporter.destroy
      redirect_to dashboard_index_path
    else
      redirect_to @reporter
    end
  end

  def show
    @activities = @reporter.activities.paginate(page: params[:p])
  end

private

  def reporter_params
    params.require(:reporter).permit(:name, :reporter_plugin_id)
  end

  def set_parameters
    return unless params[:parameters]
    params[:parameters].each do |name, value|
      option = @reporter.options.where(:key => "parameter_#{name}").first
      option = @reporter.options.new(:key => "parameter_#{name}") unless option
      option.value = value
      option.save! unless @reporter.new_record?
    end
  end
end
