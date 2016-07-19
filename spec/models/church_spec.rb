# == Schema Information
#
# Table name: churches
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  email      :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Church, :type => :model do

  it { is_expected.to have_many(:members) }
  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many(:ministries)}
  it { is_expected.to have_many(:families)}
  it { is_expected.to have_many(:responsibilities)}

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_uniqueness_of(:name)}
  it { is_expected.to validate_uniqueness_of(:email)}
  it { is_expected.to validate_length_of(:phone)}


  let!(:church) { create(:church, name: 'Presbiteriana')}

  context '.change_to_format_phone' do
    it 'returns a number when phone is present' do
      church = create(:church, phone: '34333ffd2323')
      expect(church.phone).to eq('343332323')
    end
  end
end
