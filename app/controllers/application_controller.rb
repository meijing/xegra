class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
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
end
