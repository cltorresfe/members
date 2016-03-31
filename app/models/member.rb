class Member < ActiveRecord::Base
	belongs_to :church
	belongs_to :status
	has_and_belongs_to_many :responsibilities, dependent: :destroy
	validates :name, :adress, :email, :phone, :church, presence: true
	validates :email, uniqueness: true, email: true
	validates :phone, numericality: { less_than_or_equal_to: 2147483647 }
	validates :name, length: { maximum: 35,
    	too_long: "%{count} characters is the maximum allowed" }
    validates :adress, length: { maximum: 50,
    	too_long: "%{count} characters is the maximum allowed" }
end
