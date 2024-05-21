require 'rails_helper'

RSpec.describe ItemModifierGroup, type: :model do
  it { should belong_to(:item) }
  it { should belong_to(:modifier_group) }

  it { should validate_presence_of(:item) }
  it { should validate_presence_of(:modifier_group) }
end
