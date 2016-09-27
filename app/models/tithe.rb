class Tithe < ApplicationRecord
  validates :church, :member, presence: true
  
  belongs_to :member
  belongs_to :church
end
