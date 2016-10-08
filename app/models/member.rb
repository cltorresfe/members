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
#  avatar          :string
#  role            :integer
#  family_id       :integer
#

require 'elasticsearch/model'

class Member < ApplicationRecord
  include Decorators::Member
  include SearchableMember
  include ChangeFormatPhone
  mount_uploader :avatar, AvatarUploader

  enum status: %i(active regular inactive visitor transferred deceased)
  enum role: %i(head_family father mother son daughter spouse relative)

  AGE_RANGES = [[0, 14], [15, 18], [19, 29], [30, 44], [45, 59],
                [60, 120]].freeze

  belongs_to :church
  belongs_to :family
  has_many :charge_members, dependent: :destroy
  has_many :charges, through: :charge_members
  has_many :attendances, dependent: :destroy
  has_many :ministries, -> { distinct }, through: :charges
  has_many :responsibilities, -> { distinct }, through: :charges
  has_many :tithes, dependent: :destroy

  validates :first_name, :last_name, :church, presence: true
  validates :email, email: true, allow_blank: true
  validates :phone, length: { maximum: 15, minimum: 7 }, allow_blank: true
  validates :first_name, length: { maximum: 35 }
  validates :address, length: { maximum: 100 }
  validates :facebook, facebook: true, allow_blank: true
  validates :twitter, twitter: true, allow_blank: true

  before_validation :change_to_format_phone
  before_create :set_defaults
  before_update :set_role

  scope :sorted, -> { order(created_at: :desc) }
  scope :with_birth_date, -> { where.not(birth_date: nil) }
  scope :with_email, -> { where.not(email: nil) }
  scope :active_service, -> { where('members.status = ? OR members.status = ? OR members.status = ?', 0, 1, 3) }

  def set_defaults
    self.status ||= :active
  end

  def set_role
    self.role = nil unless family
  end

  def head_family
    family.members.where('role = ?', 0) if family
  end

  def passive_status?
    %w(transferred deceased inactive).include? status
  end

  def self.administrative_for_ministry(ministry_id)
    joins(charges: [:ministry, :responsibility])
      .where('ministries.id = ?', ministry_id)
      .where('responsibilities.administrative = ?', true)
      .with_email
  end

  def self.birth_date_by_month
    where('Extract(month from birth_date) = ?
          AND Extract(day from birth_date) >= ?',
          Time.zone.now.month, Time.zone.now.day)
  end

  def self.by_gender
    by_genders = select('gender, count(*) as value').group('gender')
    members_gender = []
    by_genders.each do |m_gender|
      label = m_gender.gender_humanized
      members_gender << { label: label, value: m_gender.value }
    end
    members_gender.presence || [{ label: 'Sin información', value: 1 }]
  end

  def gender_humanized
    case gender
    when true then 'Femenino'
    when false then 'Masculino'
    when nil then 'Sin registro'
    end
  end

  def age
    now = Time.zone.now
    now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end

  def self.by_range
    list_age = []
    total = with_birth_date.count
    AGE_RANGES.each do |age_group|
      count = where('birth_date > ? AND birth_date < ? ',
                    age_group.last.years.ago, age_group.first.years.ago).count
      next unless total > 0
      list_age << { label: "#{age_group.first} - #{age_group.last} años",
                    value: "#{count * 100 / total}%", count: count }
    end
    list_age.presence || [{ label: 'Sin información', value: 1, count: 1 }]
  end

  def tithes_by_date(date_l, date_r)
    tithes.where(
      'tithes.handed_at >= ? and tithes.handed_at <= ?',
      date_l, date_r
    )
  end
end
