# == Schema Information
#
# Table name: charge_members
#
#  id         :integer          not null, primary key
#  charge_id  :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ChargeMemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
