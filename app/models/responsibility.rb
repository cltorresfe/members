# == Schema Information
#
# Table name: responsibilities
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  administrative :boolean          default("false")
#

class Responsibility < ApplicationRecord
	validates :name, presence: true, uniqueness: true
  has_many :charges
  has_many :members, through: :charges

  def members_by_church(church)
    members.where(church: church)
  end
end
