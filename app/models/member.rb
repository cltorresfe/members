# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  email      :string
#  phone      :string
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
  validates :phone, length: { maximum: 12, minimum: 7 }
  validates :name, length: { maximum: 35 }
  validates :address, length: { maximum: 50}

  after_initialize :set_defaults

  scope :sorted, -> { order(created_at: :desc) }
  before_validation :change_to_format_phone 

  def set_defaults
    self.status ||= :active
  end

  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search.downcase}%").sorted
    else
      none
    end
  end

  protected
  def change_to_format_phone
    self.phone = phone.gsub(/\D/, '') if attribute_present?("phone")
  end

end
