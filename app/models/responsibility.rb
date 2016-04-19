class Responsibility < ActiveRecord::Base
  # has_many :charges
	validates :name, presence: true, uniqueness: true
end
