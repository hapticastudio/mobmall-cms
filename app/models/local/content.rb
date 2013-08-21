class Local
  class Content < ActiveRecord::Base
    scope :confirmed, -> { where(confirmed: true) }

    def to_hash
      {
        name: name,
        description: description
      }
    end

    def confirm!
      update_attribute(:confirmed, true)
    end
  end
end
