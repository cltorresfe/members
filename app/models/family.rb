# == Schema Information
#
# Table name: families
#
#  id         :integer          not null, primary key
#  name       :string
#  married_at :datetime
#  address    :string
#  phone      :string
#  city       :string
#  country    :string
#  church_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Family < ApplicationRecord
  belongs_to :church
  has_many :members
  validates :name, presence: true
  scope :married_notification_by_month, -> {where('Extract(month from married_at) = ? ',Time.zone.now.month) }
end
