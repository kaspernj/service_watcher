class ServicesController < ApplicationController
  before_filter :set_group
  before_filter :set_and_authorize

  def new
    @service = @group.services.new
  end

  def create
    @service = @group.services.new(service_params)
    set_parameters

    if @service.save
      redirect_to ["edit", @group, @service]
    else
      render :new
    end
  end

  def edit
  end

  def update
    set_parameters

    if @service.update_attributes(service_params)
      redirect_to [@group, @service]
    else
      render :edit
    end
  end

  def destroy
    if @service.destroy
      redirect_to dashboard_index_path
    else
      redirect_to ["edit", @group, @service]
    end
  end

  def check
    begin
      @service.check
    rescue => e
      flash[:error] = _("An error occurred: %{message}", :message => e.message)
    end

    redirect_to [@group, @service]
  end

private

  def service_params
    params.require(:service).permit(:active, :name, :group_id, :plugin_id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_parameters
    return unless params[:parameters]
    params[:parameters].each do |name, value|
      option = @service.options.where(:key => "parameter_#{name}").first
      option = @service.options.new(:key => "parameter_#{name}") unless option
      option.value = value
      option.save! unless @service.new_record?
    end
  end
end
