# frozen_string_literal: true

redis_config = if Rails.env.production?
                 { url: Rails.application.secrets.sidekiq_redis_url, network_timeout: 5 }
               else
                 { url: 'redis://127.0.0.1:6379/1' }
               end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end

Sidekiq.configure_server do |config|
  config.redis = redis_config
end
