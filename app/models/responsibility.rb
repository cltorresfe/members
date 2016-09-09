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
  validates :name, presence: true, uniqueness: { scope: :church_id }
  validates :church, presence: true

  belongs_to :church
  has_many :charges
  has_many :members, -> { distinct }, through: :charges

  scope :sorted, -> { order(:name) }

  def members_by_church(church)
    members.where(church: church)
  end
end
