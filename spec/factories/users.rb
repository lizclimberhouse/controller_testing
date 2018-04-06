FactoryBot.define do
  sequence :email do |number|
    "test#{number}@test.com"
  end

  factory :user do
    first_name "Testy"
    last_name "Testerson"
    age (0..120).to_a.sample
    gender ['Male', 'Female', 'Other'].sample
    email
    password "password"
  end
end