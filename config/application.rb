require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Members
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    config.active_job.queue_adapter = :delayed_job
    config.action_mailer.default_url_options = {
        host: 'example.com'
    }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        address:'localhost',
        port: 1025
    }
  end
end
