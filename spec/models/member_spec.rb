require 'rails_helper'

RSpec.describe Member, :type => :model do

  it { is_expected.to belong_to(:church) }
  it { is_expected.to have_many(:charge_members) }
  it { is_expected.to have_many(:charges).through(:charge_members) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:phone)}
  it { is_expected.to validate_presence_of(:church)}
  it { is_expected.to validate_uniqueness_of(:email)}
  it { is_expected.to validate_length_of(:phone)}
  it { is_expected.to validate_length_of(:name)}
  it { is_expected.to validate_length_of(:address)}


  
  let!(:church) { create(:church)}
  let!(:member) { create(:member, church: church)}
  let!(:user) { create(:user, church: church)}

  describe '#search' do

    it 'searches an existing member' do
      # binding.pry
      expect(Member.search('Homero', user.church)).to include member
    end

    it 'searches an unknown member' do
      expect(Member.search('Marge', user.church)).not_to include member
    end
  end

  describe '.status_name' do
    it { expect(member.status_name).to eq 'Activo'}
  end

  describe '#get_status_name_for' do

    it { expect(Member.get_status_name_for(:active)).to eq 'Activo'}
    it { expect(Member.get_status_name_for(:regular)).to eq 'Asistente regular'}
    it { expect(Member.get_status_name_for(:inactive)).to eq 'Inactivo'}
    it { expect(Member.get_status_name_for(:visitor)).to eq 'Invitado'}
    it { expect(Member.get_status_name_for(:transferred)).to eq 'Trasladado'}
    it { expect(Member.get_status_name_for(:asdf)).to eq ''}
  end

  describe '#statuses_for_select' do

    it 'returns an array with the statuses for a select tag' do
      expect(Member.statuses_for_select).to eq([
        ["Activo", "active"], ["Asistente regular", "regular"],
        ["Inactivo", "inactive"], ["Invitado", "visitor"],
        ["Trasladado", "transferred"]]
      )
    end

  end

end
