require 'rails_helper'

RSpec.describe MemberMailer, type: :mailer do
  describe 'send_message' do
    let(:member) { create(:member, email: 'example@mail.com') }
    let(:user) { create(:user) }
    let(:mail) { MemberMailer.send_message('subject1', 'body one', member.id, user.id) }

    it 'renders the headers' do
      expect(mail.subject).to eq('subject1')
      expect(mail.to).to eq(['example@mail.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('body one')
    end

    it 'enqueues the mail' do
      expect do
        mail.deliver_later
      end.to have_enqueued_job.on_queue('mailers')
    end

    it 'sends an email' do
      expect do
        perform_enqueued_jobs do
          mail.deliver_later
        end
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it 'sends email to the right user' do
      perform_enqueued_jobs do
        mail.deliver_later
      end

      mail = ActionMailer::Base.deliveries.last
      expect(mail.reply_to[0]).to eq user.email
    end
  end

  describe 'send_notification_tithe' do
    let(:member) { create(:member, email: 'example@mail.com') }
    let(:user) { create(:user) }
    let(:tithe) { create(:tithe, member: member) }
    let(:mail) { MemberMailer.send_notification_tithe(member.id, tithe.id, user.id) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Aviso de Entrega de Diezmo')
      expect(mail.to).to eq(['example@mail.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Comprobante')
    end

    it 'enqueues the mail' do
      expect do
        mail.deliver_later
      end.to have_enqueued_job.on_queue('mailers')
    end

    it 'sends a notification tithe' do
      expect do
        perform_enqueued_jobs do
          mail.deliver_later
        end
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it 'sends notification to the right user' do
      perform_enqueued_jobs do
        mail.deliver_later
      end

      mail = ActionMailer::Base.deliveries.last
      expect(mail.reply_to[0]).to eq user.email
    end
  end
end
