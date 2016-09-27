require 'rails_helper'

RSpec.describe Tithe, type: :model do
  it { is_expected.to belong_to(:church) }
  it { is_expected.to belong_to(:member) }

  it { is_expected.to validate_presence_of(:church) }
  it { is_expected.to validate_presence_of(:member) }
end
