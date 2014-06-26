class LocalesController < ApplicationController
  def create
    I18n.locale = params[:locale]
    session[:locale] = params[:locale]
    current_user.update_attribute(:locale, params[:locale]) if signed_in?
    redirect_to :back
  end
end
