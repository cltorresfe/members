class Ministry < ActiveRecord::Base
  has_many :charges
  has_many :responsibilities, through: :charges
end
