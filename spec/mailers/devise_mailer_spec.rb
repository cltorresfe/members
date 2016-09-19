require 'rails_helper'

RSpec.describe Devise::Mailer, type: :mailer do
  let(:user) { create(:user) }

  it 'enqueues the devise mails' do
    expect do
      user.send_reset_password_instructions
    end.to have_enqueued_job.on_queue('mailers')
  end
end
