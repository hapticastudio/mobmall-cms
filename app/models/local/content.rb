class Local
  class Content < ActiveRecord::Base
    scope :confirmed,   -> { where(confirmed: true) }
    scope :unconfirmed, -> { where(confirmed: nil) }

    belongs_to :local

    def to_hash
      {
        name: name,
        description: description
      }
    end

    def confirm!
      update_attribute(:confirmed, true)
    end

    def reject!
      update_attribute(:confirmed, false)
    end
  end
end
