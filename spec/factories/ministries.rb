# == Schema Information
#
# Table name: ministries
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  church_id   :integer

FactoryGirl.define do
  factory :ministry do
    sequence :name do |n|
      "Escuela Biblica #{n}"
    end
    description { Faker::Lorem.sentence }
    church

    trait :with_responsibilities do
      transient do
        number_of_events 3
      end

      before :create do |ministry, evaluator|
        ministry.responsibilities = create_list :responsibility, evaluator.number_of_events, church: ministry.church
      end
    end
  end
end
