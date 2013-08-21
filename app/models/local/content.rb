class Local
  class Content < ActiveRecord::Base
    def to_hash
      {
        name: name,
        description: description
      }
    end
  end
end
