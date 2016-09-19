# == Schema Information
#
# Table name: charges
#
#  id                :integer          not null, primary key
#  ministry_id       :integer
#  responsibility_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null

FactoryGirl.define do
  factory :charge do
    responsibility

    factory :non_admin_charge do
      responsibility { create(:responsibility, administrative: false) }
    end
  end
end
