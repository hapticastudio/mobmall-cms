class Event < ActiveRecord::Base
  belongs_to :local

  validates :description, presence: true
  validates :begin_time, presence: true
  validates :end_time, presence: true

  validate :end_time_is_after_begin_time

  scope :updated_since, ->(updated_since){ where('updated_at > ?', updated_since) }

  def as_json(*)
    super(only: [:id, :local_id, :description, :begin_time, :end_time])
  end

  def begin_time
    super.to_s
  end

  def end_time
    super.to_s
  end

  private

  def end_time_is_after_begin_time
    if end_time and begin_time and end_time < begin_time
      errors[:end_time] << "End time has to be after begin time"
    end
  end
end
