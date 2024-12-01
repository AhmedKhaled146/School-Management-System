require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SchoolManagementSystem
  class Application < Rails::Application
    config.load_defaults 7.2

    config.autoload_lib(ignore: %w[assets tasks])


    config.time_zone = "Cairo"
    config.active_record.default_timezone = :local

    config.active_job.queue_adapter = :sidekiq

    config.api_only = true
  end
end
