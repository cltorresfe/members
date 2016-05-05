# == Schema Information
#
# Table name: churches
#
#  id         :integer          not null, primary key
#  name       :string
#  adress     :string
#  email      :string
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Church < ApplicationRecord
  has_many :members, inverse_of: :order
  has_many :users

  validates :name, :adress, :email, :phone,  presence: true
  validates :name, :email, uniqueness: true

end
