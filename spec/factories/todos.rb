FactoryGirl.define do
  factory :todo do
    name "MyString"
    description "MyText"
  end

  factory :invalid_todo, parent: :todo do
    name nil
  end
end
