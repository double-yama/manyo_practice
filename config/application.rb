require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Manyo
  class Application < Rails::Application
    config.i18n.default_locale = :ja
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # config.active_record.default_timezone = :local
    config.time_zone = 'Asia/Tokyo'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.eager_load_paths += Dir[Rails.root.join('app', 'uploaders')]
    config.eager_load_paths += %W(#{config.root}/app/uploaders)
    # config.autoload_paths += %W(#{config.root}/app/uploaders)
    config.generators.template_engine = :slim
  end
end
