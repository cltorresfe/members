require 'rails_helper'

RSpec.describe Responsibility, :type => :model do

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
