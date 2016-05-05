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

class ChargeMember < ApplicationRecord
  belongs_to :charge
  belongs_to :member
end
