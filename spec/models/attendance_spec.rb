require 'rails_helper'

RSpec.describe Attendance, :type => :model do
  it { is_expected.to belong_to(:member) }
  it { is_expected.to belong_to(:ministry) }

  let!(:church) { create(:church)}
  let!(:ministry) { create(:ministry, :with_responsibilities, church: church)}
  let!(:attendance) { create(:attendance, present: true, ministry: ministry)}

  describe '#attendances_last_week' do
    it 'returns an array with the members attendance' do
      expect(Attendance.attendances_last_week(church)).not_to be_empty
    end
  end

  describe '#by_date_and_ministry' do
    it 'returns an array with the members attendance by date' do
      expect(Attendance.by_date_and_ministry(2.days.ago.beginning_of_day, ministry.id)).not_to be_empty
    end
  end

  describe 'format_date' do
    it 'date beginning of day' do
      expect(attendance.format_date).to eq(2.days.ago.beginning_of_day)
    end

    it 'without format date' do
      expect(attendance.format_date).not_to eq(2.days.ago)
    end
  end

  describe 'human_present' do
    it 'human present' do
      expect(attendance.human_present).to eq('Presente')
    end

    let!(:attendance_absent) { create(:attendance, present: false, ministry: ministry)}

    it 'human absent' do
      expect(attendance_absent.human_present).to eq('Ausente')
    end
  end
end
