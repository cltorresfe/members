# == Schema Information
#
# Table name: ministries
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  church_id   :integer
#

class Ministry < ApplicationRecord
  belongs_to :church
  has_many :attendances
  has_many :charges, dependent: :destroy
  has_many :member_attendances, through: :attendances, source: :member
  has_many :members, -> { distinct }, through: :charges
  has_many :responsibilities, through: :charges

  validates :name, :responsibilities, :church, presence: true
  validates :name, uniqueness: { scope: :church_id }

  scope :sorted, -> { order(:name) }

  def self.by_church(church)
    where(church: church)
  end
end
