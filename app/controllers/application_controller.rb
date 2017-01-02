class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  # Set locale config
  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  def home
  end

  def health
    render text: 'ok'
  end

  # Extract locale from http header
  def extract_locale_from_accept_language_header
    return 'en' unless request.env['HTTP_ACCEPT_LANGUAGE']
    case request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      when 'en'
        'en'
      when 'pt'
        'pt-BR'
      when 'es'
        'es'
      else
        'en'
    end
  end
end
