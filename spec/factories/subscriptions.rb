FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    price { "9.99" }
    status { "MyString" }
    frequency { "MyString" }
    customer { nil }
  end
end
