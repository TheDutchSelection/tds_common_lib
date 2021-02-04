FactoryBot.define do
  factory :ability, class: 'TdsCommonLib::Ability' do
    sequence(:user_id)
    user_type { 'User' }
    permission { 'all_database_backups' }
  end
end
