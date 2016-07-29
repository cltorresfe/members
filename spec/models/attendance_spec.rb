# == Schema Information
#
# Table name: attendances
#
#  id              :integer          not null, primary key
#  member_id       :integer
#  ministry_id     :integer
#  attendance_date :datetime
#  present         :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

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
    it 'returns present value' do
      expect(attendance.human_present).to eq('Presente')
    end

    it 'returns absent value' do
      attendance.present = false
      expect(attendance.human_present).to eq('Ausente')
    end
  end
end
