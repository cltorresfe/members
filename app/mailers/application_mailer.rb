class ApplicationMailer < ActionMailer::Base
  default from: "'Admin' <no_reply@church.com>"
  layout 'mailer'
end
