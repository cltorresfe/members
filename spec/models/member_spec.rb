# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  first_name      :string
#  address         :string
#  email           :string
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  church_id       :integer
#  status          :integer
#  run             :string
#  last_name       :string
#  gender          :boolean
#  city            :string
#  country         :string
#  testimony       :text
#  facebook        :string
#  twitter         :string
#  skype           :string
#  birth_date      :datetime
#  baptism_date    :datetime
#  membership_date :datetime
#  discipline_date :datetime
#  transfer_date   :datetime
#

require 'rails_helper'

RSpec.describe Member, type: :model do
  it { is_expected.to belong_to(:church) }
  it { is_expected.to belong_to(:family) }
  it { is_expected.to have_many(:charge_members) }
  it { is_expected.to have_many(:charges).through(:charge_members) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:church) }
  it { is_expected.to validate_length_of(:phone) }
  it { is_expected.to validate_length_of(:name) }
  it { is_expected.to validate_length_of(:address) }
  it { is_expected.to allow_value('test@test.com').for(:email) }
  it { is_expected.not_to allow_value('invalid').for(:email) }

  let!(:member) { create(:member, first_name: 'Homero', last_name: 'Simpsons') }

  describe '.status_name' do
    it { expect(member.status_name).to eq 'Activo' }
  end

  describe '#get_status_name_for' do
    it { expect(Member.get_status_name_for(:active)).to eq 'Activo' }
    it { expect(Member.get_status_name_for(:regular)).to eq 'Asistente regular' }
    it { expect(Member.get_status_name_for(:inactive)).to eq 'Inactivo' }
    it { expect(Member.get_status_name_for(:visitor)).to eq 'Invitado' }
    it { expect(Member.get_status_name_for(:transferred)).to eq 'Trasladado' }
    it { expect(Member.get_status_name_for(:deceased)).to eq 'Fallecido' }
    it { expect(Member.get_status_name_for(:asdf)).to eq '' }
  end

  describe '#statuses_for_select' do
    it 'returns an array with the statuses for a select tag' do
      expect(Member.statuses_for_select).to(
        eq([%w(Activo active), ['Asistente regular', 'regular'],
            %w(Inactivo inactive), %w(Invitado visitor),
            %w(Trasladado transferred), %w(Fallecido deceased)])
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
    let!(:member) { create(:member, birth_date: 15.years.ago) }
    it 'returns an object array with the count of age´s range' do
      ranges = Member.by_range
      expect(ranges[0][:count]).to eq 0
      expect(ranges[1][:count]).to eq 1
      expect(ranges[2][:count]).to eq 0
      expect(ranges[3][:count]).to eq 0
      expect(ranges[4][:count]).to eq 0
      expect(ranges[5][:count]).to eq 0
    end

    context 'no members created' do
      before do
        Member.destroy_all
      end

      it 'returns an array with "no info" hash' do
        ranges = Member.by_range
        expect(ranges[0][:value]).to eq 1
        expect(ranges[0][:count]).to eq 1
        expect(ranges[0][:label]).to eq "Sin información"
      end
    end
  end

  describe '#by_gender' do
    context 'members created' do
      let!(:member) { create(:member, gender: nil) }
      let!(:man_member) { create(:member, gender: false) }
      let!(:woman_member) { create(:member, gender: true) }

      it 'returns an object array with the count of members by gender' do
        genders = Member.by_gender
        expect(genders[0][:value]).to eq 1
        expect(genders[1][:value]).to eq 1
        expect(genders[2][:value]).to eq 1
        expect(genders[0][:label]).to eq 'Sin registro'
        expect(genders[1][:label]).to eq 'Masculino'
        expect(genders[2][:label]).to eq 'Femenino'
      end
    end

    context 'no members created' do
      before do
        Member.destroy_all
      end

      it 'returns an array with "no info" hash' do
        genders = Member.by_gender
        expect(genders[0][:value]).to eq 1
        expect(genders[0][:label]).to eq "Sin información"
      end
    end
  end

  context '.age' do
    let!(:member) { create(:member, birth_date: 15.years.ago) }

    it 'returns the age' do
      expect(member.age).to eq 15
    end
  end

  context '.country_name' do
    subject { member.country_name }
    it { is_expected.to eq 'Chile' }
  end

  context '.full_name' do
    subject { member.full_name }
    it { is_expected.to eq 'Homero Simpsons' }
  end

  context '.semi_full_name' do
    subject { member.semi_full_name }
    it { is_expected.to eq 'Homero S.' }
  end

  context '.facebook_url' do
    let!(:member_f) { create(:member, facebook: 'homeros') }
    subject { member_f.facebook_url }
    it { is_expected.to eq 'https://www.facebook.com/homeros' }
  end

  context '.twitter_url' do
    let!(:member_t) { create(:member, twitter: 'homeros') }
    subject { member_t.twitter_url }
    it { is_expected.to eq 'https://www.twitter.com/homeros' }
  end

  describe '.avatar_url' do
    subject { member.avatar_url }

    context 'return member url' do
      let!(:member) { create(:member) }
      it { is_expected.to include 'user-m.png' }
    end

    context 'return default male url' do
      let!(:member) { create(:member, avatar: nil, gender: false) }
      it { is_expected.to eq 'default_avatar_male.png' }
    end
    context 'return default female url' do
      let!(:member) { create(:member, avatar: nil, gender: true) }
      it { is_expected.to eq 'default_avatar_female.png' }
    end

    context 'return default url' do
      let!(:member) { create(:member, avatar: nil, gender: nil) }
      it { is_expected.to eq 'default_avatar.png' }
    end
  end

  describe '#administrative_for_ministry' do
    let(:ministry) { create(:ministry) }

    it 'returns an array of administrative members given a ministry' do
      pending('queda pendiendte hasta que se cree estructura de factory girl con la asistencia')
      expect(Member.administrative_for_ministry(ministry.id)).not_to be_empty
    end
  end

  describe '.tithes_by_date' do
    let!(:date_f) { 1.year.ago.beginning_of_day }
    let!(:date_l) { Time.now}
    subject { member.tithes_by_date(date_f, date_l) }

    context 'returns an array with the tithes of the last year' do
      let!(:tithe) { create(:tithe, handed_at: 30.days.ago, member: member) }
      it { is_expected.not_to be_empty }
    end

    context 'returns an array empty without loaded tithes to member associated' do
      it { is_expected.to be_empty }
    end
  end
end
