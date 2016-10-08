# == Schema Information
#
# Table name: tithes
#
#  id         :integer          not null, primary key
#  handed_at  :datetime
#  quantity   :decimal(, )
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  church_id  :integer
#

class Tithe < ApplicationRecord
  validates :church, :member, presence: true

  belongs_to :member
  belongs_to :church
  scope :sorted, -> { order(handed_at: :asc) }
end
