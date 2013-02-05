class ApplicationController < ActionController::Base
  
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    {
        :locale => I18n.locale
    }
  end

  def links
    render 'links'
  end

  def set_start_profile
    session[:profile]="lk"
  end

  def set_profile
    session[:profile]=params[:profile]
    redirect_to new_veterinarian_session_path
  end

  def home
    session[:profile]="lk"
  end
end
