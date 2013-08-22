FactoryGirl.define do
  factory :event do
    description "A little something-something"
    begin_time { Time.now }
    end_time { 1.week.from_now }
  end
end
