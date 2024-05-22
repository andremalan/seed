# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Modifier, type: :model do
  it { should belong_to(:item) }
  it { should belong_to(:modifier_group) }

  it { should validate_presence_of(:item) }
  it { should validate_presence_of(:modifier_group) }
  it { should validate_presence_of(:display_order) }
  it { should validate_presence_of(:default_quantity) }
end
