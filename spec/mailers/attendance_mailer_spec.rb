require 'rails_helper'

RSpec.describe AttendanceMailer, type: :mailer do
  describe 'attendances_confirmation' do
    let(:ministry) { create(:ministry, :with_responsibilities) }
    let(:user) { create(:user) }
    let(:mail) { AttendanceMailer.attendances_confirmation(1.day.ago.to_s, ministry.id, user.id) }

    it 'renders the headers' do
      pending('queda pendiente hasta que tengamos la estructura del factory girl de asistencia')
      expect(mail.subject).to eq("Confirmación de registro de asistencia")
      expect(mail.to).to eq([''])
      expect(mail.from).to eq(['no_reply@church.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Estimado')
    end

    it 'sends the email' do
      pending('queda pendiente hasta que tengamos la estructura del factory girl de asistencia')
      expect do
        mail.deliver
      end.to have_enqueued_job.on_queue('mailers')
    end
  end
end
