require 'rails_helper'

RSpec.describe Member, :type => :model do

  it { is_expected.to belong_to(:church) }
  it { is_expected.to have_many(:charge_members) }
  it { is_expected.to have_many(:charges).through(:charge_members) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:church)}
  it { is_expected.to validate_uniqueness_of(:email)}
  it { is_expected.to validate_length_of(:phone)}
  it { is_expected.to validate_length_of(:name)}
  it { is_expected.to validate_length_of(:address)}


  let!(:member) { create(:member, first_name: 'Homero')}

  describe '#search' do
    it 'searches an existing member' do
      expect(Member.search('Homero')).to include member
    end

    it 'searches an unknown member' do
      expect(Member.search('Marge')).not_to include member
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

  context '.change_to_format_phone' do
    it 'returns a number when phone is present' do
      member = create(:member, phone: '34333ffd2323')
      expect(member.phone).to eq('343332323')
    end
  end

  context '#by_range' do
    let!(:man_member){ create(:member, birth_date: 15.years.ago)}
    it 'returns an object array with the count of age´s range' do
      ranges = Member.by_range
      expect(ranges[0][:count]).to eq 0
      expect(ranges[1][:count]).to eq 1
      expect(ranges[2][:count]).to eq 0
      expect(ranges[3][:count]).to eq 0
      expect(ranges[4][:count]).to eq 0
      expect(ranges[5][:count]).to eq 0
    end
  end

  describe '#by_gender' do

    context 'members with gender assigned' do
      let!(:man_member){ create(:member, gender: false)}
      let!(:woman_member){ create(:member, gender: true)}
      it 'returns an object array with the count of members by gender' do
        genders = Member.by_gender
        expect(genders[0][:value]).to eq 1
        expect(genders[1][:value]).to eq 1
        expect(genders[2][:value]).to eq 1
        expect(genders[0][:label]).to eq "Sin registro"
        expect(genders[1][:label]).to eq "Masculino"
        expect(genders[2][:label]).to eq "Femenino"
      end
    end
    context 'member without gender assigned' do

      it 'returns an object array with the count of members without gender ' do
        genders = Member.by_gender
        expect(genders[0][:value]).to eq 1
        expect(genders[0][:label]).to eq "Sin registro"

      end
    end
  end

  context '.age' do
    let!(:member){ create(:member, birth_date: 15.years.ago)}
    it 'returns the age' do
      expect(member.age).to eq 15
    end
  end
end

