class MemberMailer < ApplicationMailer
  def send_message(subject, body, member_id, user_id)
    @user = User.find(user_id)
    @member = Member.find(member_id)
    @body = body
    mail to: @member.email, subject: subject, reply_to: @user.email
  end
end
