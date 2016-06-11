require 'rails_helper'

RSpec.describe Responsibility, :type => :model do

  describe '#by_church' do
    let!(:church) { create(:church)}
    let!(:member) { create(:member, church: church)}
    let!(:responsibility) { create(:responsibility)}

    subject {Responsibility.by_church(church)}

    context 'returns an array with the responsibilities of church' do
      let!(:responsibilities) {[responsibility]}
      let!(:ministry) { create(:ministry, church: church, responsibilities: responsibilities)}
      let!(:charge) { create(:charge, responsibility:responsibility, ministry: ministry )}
      let!(:charge_member) { create(:charge_member, charge:charge, member: member )}

      it {is_expected.not_to be_empty}
    end

    context 'returns an array empty without loaded responsibilities to church associated' do
      it {is_expected.to be_empty}
    end
  end
end
