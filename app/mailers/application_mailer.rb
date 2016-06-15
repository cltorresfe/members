class ApplicationMailer < ActionMailer::Base
  default from: "'#{current_user.name}' <#{current_user.email}>"
  layout 'mailer'
end
