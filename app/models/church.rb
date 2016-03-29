class Church < ActiveRecord::Base
	has_many :members, inverse_of: :order
	validates :name, :adress, :email, :phone,  presence: true
	validates :name, :email, uniqueness: true

end
