# == Schema Information
#
# Table name: responsibilities
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  administrative :boolean          default("false")
#  church_id      :integer
#

class Responsibility < ApplicationRecord
  validates :name, presence: true, uniqueness: {scope: :church_id}
  validates :church, presence: true

  has_many :charges
  has_many :members, through: :charges
  belongs_to :church

  def members_by_church(church)
    members.where(church: church)
  end

  def self.by_church(church)
    where(church: church)
  end
end
