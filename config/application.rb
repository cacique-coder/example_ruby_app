require File.expand_path('../boot', __FILE__)

require 'rails/all'
Bundler.require(*Rails.groups)

module ExampleAppRuby
  class Application < Rails::Application
    config.middleware.use ActionDispatch::Flash
    config.time_zone = 'Caracas'
    config.autoload_paths << Rails.root.join('lib')
    config.active_job.queue_adapter = :sidekiq
    config.api_only = false
    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false, :fixture_replacement => :factory_girl
    end
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
        html_tag
    }
    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end
