class Local
  class Content < ActiveRecord::Base
    def to_hash
      {
        name: name,
        description: description
      }
    end

    def description=(description)
      super unless description.blank?
    end
  end
end
