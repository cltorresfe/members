require 'rails_helper'

RSpec.describe Member, :type => :model do

  it { is_expected.to belong_to(:church) }
  it { is_expected.to belong_to(:status) }
  it { is_expected.to have_many(:charge_members) }
  it { is_expected.to have_many(:charges).through(:charge_members) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:phone)}
  it { is_expected.to validate_presence_of(:church)}
  it { is_expected.to validate_uniqueness_of(:email)}
  it { is_expected.to validate_numericality_of(:phone)}
  it { is_expected.to validate_length_of(:name)}
  it { is_expected.to validate_length_of(:address)}


  context '#search' do
    let(:member) { create(:member, name: 'Homero')}

    it 'searches an existing member' do
      expect(Member.search('Homero')).to include member
    end

    it 'searches an unknown member' do
      expect(Member.search('Marge')).not_to include member
    end
  end
end
