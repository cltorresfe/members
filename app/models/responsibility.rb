# == Schema Information
#
# Table name: responsibilities
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Responsibility < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
end
