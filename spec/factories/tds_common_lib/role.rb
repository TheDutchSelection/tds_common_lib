FactoryBot.define do
  factory :role, class: 'TdsCommonLib::Role' do
    name { 'editor' }
    user_type { 'User' }

    initialize_with { new(attributes[:user_type], attributes[:name]) }
  end
end
