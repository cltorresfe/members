# == Schema Information
#
# Table name: ministries
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Ministry < ApplicationRecord
  has_many :charges
  has_many :responsibilities, through: :charges
  belongs_to :church
  has_many :attendances
  has_many :member_attendances, through: :attendances
  has_many :members, through: :charges
end
