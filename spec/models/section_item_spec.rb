require 'rails_helper'

RSpec.describe SectionItem, type: :model do
  it { should belong_to(:section) }
  it { should belong_to(:item) }

  it { should validate_presence_of(:section) }
  it { should validate_presence_of(:item) }
  it { should validate_presence_of(:display_order) }
end
