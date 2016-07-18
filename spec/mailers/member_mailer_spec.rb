require "rails_helper"

RSpec.describe MemberMailer, :type => :mailer do
  describe "send_message" do
    let(:member) { create(:member, email: 'example@mail.com')}
    let(:user){ create(:user)}
    let(:mail) { MemberMailer.send_message( 'subject1', 'body one', member.id, user.id) }

    it "renders the headers" do
      expect(mail.subject).to eq("subject1")
      expect(mail.to).to eq(["example@mail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("body one")
    end

    it "enqueues the mail" do
      expect {
        mail.deliver_later
      }.to have_enqueued_job.on_queue('mailers')
    end

    it "sends an email" do
      expect {
        perform_enqueued_jobs do
          mail.deliver_later
        end
      }.to change{ ActionMailer::Base.deliveries.size }.by(1)
    end

    it 'sends email to the right user' do
        perform_enqueued_jobs do
            mail.deliver_later
        end

        mail = ActionMailer::Base.deliveries.last
        expect(mail.reply_to[0]).to eq user.email
    end


  end

end
