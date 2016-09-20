# == Schema Information
#
# Table name: charges
#
#  id                :integer          not null, primary key
#  ministry_id       :integer
#  responsibility_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe Charge, type: :model do
  it { is_expected.to belong_to(:ministry) }
  it { is_expected.to belong_to(:responsibility) }
  it { is_expected.to have_many(:charge_members) }
  it { is_expected.to have_many(:members).through(:charge_members) }

  describe '#non_administrative' do
    let(:admin_charge) { create(:charge) }
    let(:non_admin_charge) { create(:non_admin_charge) }

    it { expect(Charge.non_administrative).to include non_admin_charge }
    it { expect(Charge.non_administrative).not_to include admin_charge }
  end
end
