require_relative 'boot'

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KHUTRO
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # BLOOMGOO.VN: Rails generator controller without tests, assets & helpers
    config.generators.assets = false
    config.generators.helper = false

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :'vi'
    config.autoload_paths += %W["#{config.root}/app/validators/"]

    Koala.http_service.http_options = {:ssl => { :verify_mode => OpenSSL::SSL::VERIFY_NONE }}
  end
end
