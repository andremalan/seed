require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should have_many(:section_items) }
  it { should have_many(:sections).through(:section_items) }
  it { should have_many(:item_modifier_groups) }
  it { should have_many(:modifier_groups).through(:item_modifier_groups) }
  it { should have_many(:modifiers) }

  it { should validate_presence_of(:label) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:type) }
end
