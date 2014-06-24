class GroupsController < ApplicationController
  before_filter :set_and_authorize
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    
    if @group.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @group.update_attributes(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end
  
  def destroy
    if @group.destroy
      redirect_to dashboard_index_path
    else
      flash[:error] = @group.errors.full_messages.join(". ")
      redirect_to group_path(@group)
    end
  end
  
private
  
  def group_params
    params.require(:group).permit(:name)
  end
end
