# frozen_string_literal: true

lass ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
