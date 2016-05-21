require 'rails_helper'

RSpec.describe Family, :type => :model do

  it { is_expected.to belong_to(:church) }

  it { is_expected.to validate_presence_of(:name) }

end
