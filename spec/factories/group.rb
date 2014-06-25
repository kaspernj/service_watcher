FactoryGirl.define do
  factory :group do
    name { Forgery(:lorem_ipsum).words(3) }
  end
end
