require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Conversa
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.autoload_paths += %W[#{config.root}/lib]
    config.action_mailer.preview_path = "#{Rails.root}/lib/mailer_previews"

    config.generators do |g|
      g.factory_girl    true
      g.test_framework  :rspec
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
      g.decorator       false
    end
  end
end
