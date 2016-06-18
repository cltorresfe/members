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
  include ChangeFormatPhone

  enum status: %i(active regular inactive visitor transferred)

  AGE_RANGES = [[0,14],[15,18],[19,29],[30,44],[45,59],[60,120]]

  belongs_to :church
  has_many :charge_members
  has_many :charges, through: :charge_members
  has_many :attendances

  validates :first_name, :last_name, :church, presence: true
  validates :email, uniqueness: true, email: true, allow_blank: true
  validates :phone, length: { maximum: 12, minimum: 7 }, allow_blank: true
  validates :first_name, length: { maximum: 35 }
  validates :address, length: { maximum: 100}

  before_create :set_defaults

  scope :sorted, -> { order(created_at: :desc) }
  scope :with_birth_date, -> { where.not(birth_date: nil) }
  scope :birth_date_by_month, -> {where('Extract(month from birth_date) = ? AND Extract(day from birth_date) >= ?',Time.zone.now.month, Time.zone.now.day) }
  before_validation :change_to_format_phone

  def set_defaults
    self.status ||= :active
  end

  def self.administrative_for_ministry(ministry_id)
    joins(charges: [:ministry, :responsibility]).
    where('ministries.id = ?', ministry_id).
    where('responsibilities.administrative = ?', true)
  end

  def self.search(search)
    if search
      where('lower(first_name) LIKE ?', "%#{search.downcase}%").sorted
    else
      none
    end
  end

  def self.by_gender
    by_genders = select("gender, count(*) as value").group("gender")
    members_gender = []
    by_genders.each do |m_gender|
      label = case m_gender.gender
              when true then "Femenino"
              when false then "Masculino"
              when nil then "Sin registro"
              end
      members_gender << { label: label, value: m_gender.value }
    end
    members_gender.presence || [{ label: 'Sin información', value: 1 }]
  end

  def age
    now = Time.zone.now
    now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end

  def self.by_range
    list_age = []
    total = self.with_birth_date.count
    AGE_RANGES.each do |age_group|
      count = where('birth_date > ? AND birth_date < ? ',age_group.last.years.ago, age_group.first.years.ago).count
      if(total > 0)
        list_age << {
          label: "#{age_group.first} - #{age_group.last} años",
          value: "#{count*100/total}%",
          count: count
        }
      end
    end
    list_age.presence || [{ label: 'Sin información', value: 1, count: 1 }]
  end

end
