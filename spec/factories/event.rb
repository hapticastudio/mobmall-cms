FactoryGirl.define do
  factory :event do
    name "A little something-something"
    description "Brief description of a little something-something"
    begin_time { Time.now }
    end_time { 1.week.from_now }
  end
end
