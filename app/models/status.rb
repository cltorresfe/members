# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Status < ApplicationRecord
	has_many :members
	validates :name, presence: true, uniqueness: true
end
