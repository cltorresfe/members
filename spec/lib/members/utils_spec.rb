require 'rails_helper'

describe Utils do

  it 'Returns the prioritary country codes for country_select' do
    expect(Utils::PRIORITARY_COUNTRIES).to eq ['CL']
  end
end
