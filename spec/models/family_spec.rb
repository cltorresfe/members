# == Schema Information
#
# Table name: families
#
#  id         :integer          not null, primary key
#  name       :string
#  married_at :datetime
#  address    :string
#  phone      :string
#  city       :string
#  country    :string
#  church_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Family, :type => :model do

  it { is_expected.to belong_to(:church) }
  it { is_expected.to have_many(:members) }
  it { is_expected.to validate_presence_of(:name) }

end
