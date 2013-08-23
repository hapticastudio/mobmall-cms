module UpdatedSinceScope
  extend ActiveSupport::Concern

  included do
    scope :updated_since, ->(updated_since){ where('updated_at > ?', updated_since) }
  end
end
