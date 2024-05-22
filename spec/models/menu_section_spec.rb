# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MenuSection, type: :model do
  it { should belong_to(:menu) }
  it { should belong_to(:section) }

  it { should validate_presence_of(:menu) }
  it { should validate_presence_of(:section) }
  it { should validate_presence_of(:display_order) }
end
