class Tagging < ActiveRecord::Base
  belongs_to :tag, touch: true
  belongs_to :local
end
