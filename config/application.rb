require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InstagramCloneApp
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.i18n.default_locale = :ja
    config.load_defaults 6.0

    config.action_mailer.asset_host = 'http://example.com'

    config.generators do |g|
      g.assets false
      g.helper false
    end
  end
end
