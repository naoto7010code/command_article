FactoryBot.define do
  factory :user do
    username              {'test'}
    email                 {'test@example'}
    password              {'000000'}
    password_confirmation {password}
  end
end