# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  name       :string
#  adress     :string
#  email      :string
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  church_id  :integer
#  status_id  :integer
#

require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
