# == Schema Information
#
# Table name: churches
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  email      :string
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Church < ApplicationRecord
  has_many :members
  has_many :users
  has_many :ministries
  has_many :families

  validates :name, :address, presence: true
  validates :name, :email, uniqueness: true

end
