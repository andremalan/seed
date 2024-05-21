require 'rails_helper'

RSpec.describe Menu, type: :model do
  it { should have_many(:menu_sections) }
  it { should have_many(:sections).through(:menu_sections) }

  it { should validate_presence_of(:label) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
end
