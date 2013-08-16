FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "user#{n}@factory.com" }
    password "secret" 

    factory :admin do
      role "admin"
    end
  end
end
