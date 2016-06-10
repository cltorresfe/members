require 'rails_helper'

RSpec.describe Responsibility, :type => :model do

  describe '#by_church' do

    context 'returns an array with the responsibilities of church' do
      let!(:church) { create(:church)}
      let!(:member) { create(:member, church: church)}
      let!(:responsibility) { create(:responsibility)}
      let!(:responsibilities) {[responsibility]}
      let!(:ministry) { create(:ministry, church: church, responsibilities: responsibilities)}
      let!(:charge) { create(:charge, responsibility:responsibility, ministry: ministry )}
      let!(:charge_member) { create(:charge_member, charge:charge, member: member )}

      it 'returns an array' do
        expect(Responsibility.by_church(church)).not_to be_empty 
      end
    end

    context 'returns an array empty without loaded responsibilities to church associated' do 
      let!(:church) { create(:church)}
      let!(:member) { create(:member, church: church)}
      let!(:responsibility) { create(:responsibility)}
      it 'returns an array' do
        expect(Responsibility.by_church(church)).to be_empty 
      end
      
    end

  end


end

