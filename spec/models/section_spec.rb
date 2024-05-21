require 'rails_helper'

RSpec.describe Section, type: :model do
  it { should have_many(:menu_sections) }
  it { should have_many(:menus).through(:menu_sections) }
  it { should have_many(:section_items) }
  it { should have_many(:items).through(:section_items) }

  it { should validate_presence_of(:label) }
  it { should validate_presence_of(:description) }
end
