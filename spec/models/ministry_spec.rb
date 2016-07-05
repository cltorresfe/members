require 'rails_helper'

RSpec.describe Ministry, :type => :model do

  it { is_expected.to belong_to(:church) }
  it { is_expected.to have_many(:charges) }
  it { is_expected.to have_many(:responsibilities) }
  it { is_expected.to have_many(:attendances) }
  it { is_expected.to have_many(:members).through(:charges) }
  it { is_expected.to have_many(:member_attendances).through(:attendances) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:church) }
  it { is_expected.to validate_presence_of(:responsibilities)}
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:church_id)}

  let!(:church) { create(:church)}

  describe '#by_church' do
    
    subject {Ministry.by_church(church)}

    context 'returns an array with the ministries of church' do
      let!(:ministry) { create(:ministry, :with_responsibilities, church: church)}

      it {is_expected.not_to be_empty}
    end

    context 'returns an array empty without loaded ministries to church associated' do
      it {is_expected.to be_empty}
    end
  end

  context 'return an array with members distinct through charges' do    
    let!(:ministry) { create(:ministry, :with_responsibilities, church: church )}
    let!(:member) { create(:member, church: church, charges: ministry.charges)}

    it { expect(ministry.members.length).to eq(1) }
  end

  describe '.attendances_by_member' do

    let!(:ministry) { create(:ministry, :with_responsibilities, church: church )}
    let!(:member) { create(:member, church: church)}
    subject {ministry.attendances_by_member(member)}

    context 'returns an array with the attendance of member' do
      let!(:attendance) { create(:attendance, member: member, ministry: ministry)}

      it {is_expected.not_to be_empty}
    end

    context 'returns an array empty without loaded attendances to member associated' do
      it {is_expected.to be_empty}
    end
  end

  describe '.attendances_by_date' do

    let!(:ministry) { create(:ministry, :with_responsibilities)}
    let!(:date) { 1.day.ago.beginning_of_day }
    subject {ministry.attendances_by_date(date, date)}

    context 'returns an array with the attendance of a day' do
      let!(:attendance) { create(:attendance, ministry: ministry, attendance_date: date)}

      it {is_expected.not_to be_empty}
    end

    context 'returns an array empty without loaded attendances to member associated' do
      it {is_expected.to be_empty}
    end
  end

  describe '.percent_attendances_by_member' do

    let!(:ministry) { create(:ministry, :with_responsibilities, church: church )}
    let!(:member) { create(:member, church: church)}
    subject {ministry.percent_attendances_by_member(member)}

    context 'returns a percent with the attendance of member' do
      let!(:attendance) { create(:attendance, member: member, ministry: ministry)}

      it {is_expected.to eq(100)}
    end

    context 'returns a percent valid without the attendance of member' do
      let!(:attendance) { create(:attendance, member: member, ministry: ministry, present: false)}

      it {is_expected.to eq(0)}
    end

    context 'returns nil without loaded attendances to member associated' do
      it {is_expected.to eq(nil)}
    end
  end

  describe '.percent_attendances_by_date' do

    let!(:ministry) { create(:ministry, :with_responsibilities )}
    let!(:date) { 1.day.ago.beginning_of_day }
    subject {ministry.percent_attendances_by_date(date, date)}

    context 'returns a percent with the attendance of a day' do
      let!(:attendance) { create(:attendance, ministry: ministry, attendance_date: date)}
      it {is_expected.to eq(100)}
    end

    context 'returns a percent valid without the attendance of a day' do
      let!(:attendance) { create(:attendance, ministry: ministry, attendance_date: date, present: false)}

      it {is_expected.to eq(0)}
    end

    context 'returns nil without loaded attendances to member associated' do
      it {is_expected.to eq(nil)}
    end
  end

end
