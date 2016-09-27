FactoryGirl.define do
  factory :tithe do
    handed_at 2.days.ago
    quantity "9.99"
    member
    church
  end
end
