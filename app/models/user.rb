# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  church_id              :integer
#  role                   :integer
#

class User < ActiveRecord::Base
  belongs_to :church
  enum role: %i(admin common)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email, :name
  validates_uniqueness_of :email

  before_create :set_default_role

  roles.each do |key, _value|
    define_method "#{key}?" do
      role == key
    end
  end

  def set_default_role
    self.role ||= :common
  end

  def search_members(search)
    church.members.search(search)
  end

  # To send devise emails asynchronously
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

end
