require 'rails_helper'

RSpec.describe ApplicationHelper do

  context '#prioritary_countries' do
    subject{ helper.prioritary_countries }

    it { is_expected.to eq(['CL'])}
  end
end