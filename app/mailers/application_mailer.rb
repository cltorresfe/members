class ApplicationMailer < ActionMailer::Base
  default from: ENV["NAME_EMAIL"] 
  layout 'mailer'
end
