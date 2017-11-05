# frozen_string_literal: true

SparkPostRails.configure do |c|
  c.api_key = Rails.application.secrets.sparkpost_api
  c.transactional = true
end
