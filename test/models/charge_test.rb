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

require 'test_helper'

class ChargeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
