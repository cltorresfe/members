class Tithe < ApplicationRecord
  validates :church, presence: true
  
  belongs_to :member
  belongs_to :church
end
