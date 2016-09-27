class MemberMailer < ApplicationMailer
  def send_message(subject, body, member_id, user_id)
    @user = User.find(user_id)
    @member = Member.find(member_id)
    @body = body
    mail to: @member.email, subject: subject, reply_to: @user.email
  end

  def send_notification_tithe(member_id, tithe_id, user_id)
    @user = User.find(user_id)
    @member = Member.find(member_id)
    @tithe = Tithe.find(tithe_id)
    mail to: @member.email, subject: I18n.t('member_mailer.send_notification_tithe.subject'),
        reply_to: @user.email
  end
end
