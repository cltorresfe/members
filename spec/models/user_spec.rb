# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  church_id              :integer
#  role                   :integer
#

require 'rails_helper'

RSpec.describe User, :type => :model do

  it { is_expected.to belong_to(:church) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }

  let!(:user) { create(:user)}

  context '.set_default_role' do
    it 'set common role as default' do
      user = create(:user, role: nil)
      expect(user.role).to eq 'common'
    end
  end

  context 'checking role type' do
    it 'returns true only when user has admin role' do
      user = create(:user, role: :admin)
      expect(user.admin?).to be_truthy
      expect(user.common?).to be_falsey
    end

    it 'returns true only when user has common role' do
      user = create(:user, role: :common)
      expect(user.common?).to be_truthy
      expect(user.admin?).to be_falsey
    end
  end

  context '#checking search_members' do
    let!(:church){ create(:church, name: 'Iglesia')}
    let!(:member) { create(:member, first_name: 'Plumero', church: church)}
      
    it 'searches an existing member' do
      user = create(:user, church: church)
      expect(user.search_members('Plumero')).to include member
    end

    it 'searches an unknown member' do
      expect(user.search_members('Margaret')).not_to include member
    end
  end

end
