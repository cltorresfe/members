# == Schema Information
#
# Table name: responsibilities
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  administrative :boolean          default("false")
#  church_id      :integer
#

FactoryGirl.define do
  factory :responsibility do
    sequence :name do |n|
      "Cargo #{n}"
    end
    administrative true
    church
  end
end
