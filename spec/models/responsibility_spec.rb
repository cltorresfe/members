require 'rails_helper'

RSpec.describe Responsibility, :type => :model do

  it { is_expected.to belong_to(:church) }
  it { is_expected.to have_many(:charges) }
  it { is_expected.to have_many(:members).through(:charges) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:church)}
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:church_id)}

  let!(:church) { create(:church)}

  context 'return an array with members distinct through charges' do
    let!(:responsibilities) { create_list(:responsibility, 3, church: church)}
    let!(:ministry_1) { create(:ministry, responsibilities: responsibilities, church: church )}
    let!(:ministry_2) { create(:ministry, responsibilities: responsibilities, church: church )}
    let!(:member) { create(:member, church: church, charges: Charge.all)}

    it { expect(Responsibility.last.members.length).to eq(1) }
  end
end
