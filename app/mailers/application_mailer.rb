# frozen_string_literal: true

# :nocov:
# ApplicationMailer
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
# :nocov:
