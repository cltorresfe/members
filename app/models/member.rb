# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  first_name      :string
#  address         :string
#  email           :string
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  church_id       :integer
#  status          :integer
#  run             :string
#  last_name       :string
#  gender          :boolean
#  city            :string
#  country         :string
#  testimony       :text
#  facebook        :string
#  twitter         :string
#  skype           :string
#  birth_date      :datetime
#  baptism_date    :datetime
#  membership_date :datetime
#  discipline_date :datetime
#  transfer_date   :datetime
#

class Member < ApplicationRecord
  include Decorators::Member

  enum status: %i(active regular inactive visitor transferred)

  AGE_RANGES = [[0,14],[15,18],[19,29],[30,44],[45,60],[60,120]]

  belongs_to :church
  has_many :charge_members
  has_many :charges, through: :charge_members

  validates :first_name, :last_name, :address, :church, presence: true
  validates :email, uniqueness: true, email: true
  validates :phone, length: { maximum: 12, minimum: 7 }
  validates :first_name, length: { maximum: 35 }
  validates :address, length: { maximum: 100}

  before_create :set_defaults

  scope :sorted, -> { order(created_at: :desc) }
  scope :with_birth_date, -> { where.not(birth_date: nil) }
  before_validation :change_to_format_phone 

  def set_defaults
    self.status ||= :active
  end

  def self.search(search)
    if search
      where('lower(first_name) LIKE ?', "%#{search.downcase}%").sorted
    else
      none
    end
  end

  def self.by_gender
    select("gender as label, count(*) as value").group("gender")
  end

  def age
    now = Time.now.utc.to_date
    now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end

  def self.by_range
    list_age = []
    total = self.with_birth_date.count
    AGE_RANGES.each do |age_group|
      count = where('birth_date > ? AND birth_date < ? ',age_group.last.years.ago, age_group.first.years.ago).count
      list_age << {
        label: "#{age_group.first} - #{age_group.last} años",
        value: "#{count*100/total}%",
        count: count
      }
    end
    list_age
  end

  protected
  def change_to_format_phone
    self.phone = phone.gsub(/\D/, '') if attribute_present?("phone")
  end

end
