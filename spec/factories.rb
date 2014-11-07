FactoryGirl.define do
  factory :profile do
    sequence(:id) { |n| n }
    name "John"
    surname  "Doe"

    trait :with_position do
      after :create do |prof|
        company = create :company
        create :position, profile: prof, company_id: company.id
      end
    end
  end

  factory :position do
    sequence(:id) { |n| n }
    title 'Position'
  end

  factory :company do
    sequence(:id) { |n| n }
    name 'Company'
  end
end