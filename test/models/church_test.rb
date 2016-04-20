# == Schema Information
#
# Table name: churches
#
#  id         :integer          not null, primary key
#  name       :string
#  adress     :string
#  email      :string
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ChurchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
