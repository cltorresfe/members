# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  email      :string
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  church_id  :integer
#  status     :integer
#

class Member < ApplicationRecord
  include Decorators::Member

  enum status: %i(active regular inactive visitor transferred)

  belongs_to :church
  has_many :charge_members
  has_many :charges, through: :charge_members

  validates :name, :address, :email, :phone, :church, presence: true
  validates :email, uniqueness: true, email: true
  validates :phone, numericality: { less_than_or_equal_to: 2147483647 }
  validates :name, length: { maximum: 35,
            too_long: "%{count} characters is the maximum allowed" }
  validates :address, length: { maximum: 50,
            too_long: "%{count} characters is the maximum allowed" }

  after_initialize :set_defaults

  scope :sorted, -> { order(created_at: :desc) }


  def set_defaults
    self.status ||= :active
  end

  def self.search(search, church_id)
    if search
      where(church_id: church_id).
      where('lower(name) LIKE ?', "%#{search.downcase}%").sorted
    else
      none
    end
  end

end
