# Preview all emails at http://localhost:3000/rails/mailers/welcome_member
class WelcomeMemberPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/welcome_member/notify
  def notify
    WelcomeMember.notify Member.first
  end

end
