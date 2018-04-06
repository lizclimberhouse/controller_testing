FactoryBot.define do
  factory :bank_account do
     amount (1..1000000).to_a.sample
     institution "Chase"
     description "Lotto Winnings"
     user
  end
end