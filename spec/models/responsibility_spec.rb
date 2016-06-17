require 'rails_helper'

RSpec.describe Responsibility, :type => :model do

  it { is_expected.to belong_to(:church) }
  it { is_expected.to have_many(:charges) }
  it { is_expected.to have_many(:members).through(:charges) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:church)}
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:church_id)}

  describe '#by_church' do
    let!(:church) { create(:church)}

    subject {Responsibility.by_church(church)}

    context 'returns an array with the responsibilities of church' do
      let!(:responsibility) { create(:responsibility, church: church)}

      it {is_expected.not_to be_empty}
    end

    context 'returns an array empty without loaded responsibilities to church associated' do
      it {is_expected.to be_empty}
    end
  end
end
