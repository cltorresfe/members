# == Schema Information
#
# Table name: churches
#
#  id         :integer          not null, primary key
#  name       :string
#  address     :string
#  email      :string
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Church < ApplicationRecord
  has_many :members, inverse_of: :order
  has_many :users

  validates :name, :address, :email, :phone,  presence: true
  validates :name, :email, uniqueness: true

end
