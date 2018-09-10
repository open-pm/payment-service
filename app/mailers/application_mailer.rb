# frozen_string_literal: true

# This class should be used as an Application Mailer if necessary
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
