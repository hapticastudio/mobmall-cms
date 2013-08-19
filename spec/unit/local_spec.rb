require 'spec_helper'

describe Local do
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should belong_to :user }
end
