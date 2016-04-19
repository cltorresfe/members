class Church < ActiveRecord::Base
  has_many :members, inverse_of: :order
  has_many :users

  validates :name, :adress, :email, :phone,  presence: true
  validates :name, :email, uniqueness: true

end
