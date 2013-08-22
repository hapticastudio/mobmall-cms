require 'spec_helper'

describe Event do
  it { should belong_to :local }

  it { should validate_presence_of :description }
  it { should validate_presence_of :begin_time }
  it { should validate_presence_of :end_time }

  it "validates if end time is after begin time" do
    event = Event.new(begin_time: Time.now, end_time: 2.days.ago)
    event.valid?
    event.errors['end_time'].should include('End time has to be after begin time')
  end
end
