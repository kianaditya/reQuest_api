FactoryBot.define do
  factory :offer do
    message { 'iI want  to help' }
    association :helper, factory: :user
    association :request
    status { 'pending' }
  end
end
