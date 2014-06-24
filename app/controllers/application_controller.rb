class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
private
  
  def set_and_authorize
    clazz_name = StringCases.snake_to_camel(controller_name).singularize
    clazz = Kernel.const_get(clazz_name)
    instance_name = StringCases.camel_to_snake(clazz_name)
    
    if params[:id].to_i > 0
      instance = clazz.find(params[:id])
      instance_variable_set("@#{instance_name}", instance)
      authorize! action_name.to_sym, instance
    else
      authorize! action_name.to_sym, clazz
    end
  end
end
