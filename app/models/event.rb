class Event < ActiveRecord::Base
  belongs_to :local

  validates :description, presence: true
  validates :begin_time, presence: true
  validates :end_time, presence: true

  validate :end_time_is_after_begin_time

  private

  def end_time_is_after_begin_time
    if end_time and begin_time and end_time < begin_time
      errors[:end_time] << "End time has to be after begin time"
    end
  end
end