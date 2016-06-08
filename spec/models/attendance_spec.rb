require 'rails_helper'

RSpec.describe Attendance, :type => :model do

  it { is_expected.to belong_to(:member) }
  it { is_expected.to belong_to(:ministry) }


  
  let!(:church) { create(:church)}
  let!(:ministry) { create(:ministry, church: church)}
  let!(:attendance) { create(:attendance, present: true, ministry: ministry)}
  describe '#attendances_last_week' do

    it 'returns an array with the members attendance' do
      expect(Attendance.attendances_last_week(church)).not_to be_empty 
    end

  end


end

