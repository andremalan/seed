# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ModifierGroup, type: :model do
  it { should have_many(:item_modifier_groups) }
  it { should have_many(:items).through(:item_modifier_groups) }
  it { should have_many(:modifiers) }

  it { should validate_presence_of(:label) }
  it { should validate_presence_of(:selection_required_min) }
  it { should validate_presence_of(:selection_required_max) }
end
