# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Menu Management', type: :feature do
  before(:each) do
    @menu = Menu.create!(label: 'Pizza Menu', state: 'active', start_date: '2024-05-01', end_date: '2024-12-31')
    @section = Section.create!(label: 'Classic Pizzas',
                               description: 'Traditional Italian pizzas with a variety of toppings.')
    @item = Item.create!(label: 'Margherita Pizza',
                         description: 'Classic pizza with tomatoes, mozzarella cheese, and fresh basil.', price: 800, type: 'Product')
    @modifier_group = ModifierGroup.create!(label: 'Pizza Size', selection_required_min: 1, selection_required_max: 1)
    @modifier_item = Item.create!(label: '10" Pizza', description: 'Small 10 inch pizza', price: 800, type: 'Component')
    @modifier = Modifier.create!(item: @modifier_item, modifier_group: @modifier_group, display_order: 1,
                                 default_quantity: 1, price_override: 0)

    @menu_section = MenuSection.create!(menu: @menu, section: @section, display_order: 1)
    @section_item = SectionItem.create!(section: @section, item: @item, display_order: 1)
    @item_modifier_group = ItemModifierGroup.create!(item: @item, modifier_group: @modifier_group)
  end

  it 'creates a complete menu with sections, items, modifier groups, and modifiers' do
    expect(@menu.sections).to include(@section)
    expect(@section.items).to include(@item)
    expect(@item.modifier_groups).to include(@modifier_group)
    expect(@modifier_group.modifiers).to include(@modifier)

    expect(@menu.label).to eq('Pizza Menu')
    expect(@section.label).to eq('Classic Pizzas')
    expect(@item.label).to eq('Margherita Pizza')
    expect(@modifier_group.label).to eq('Pizza Size')
    expect(@modifier_item.label).to eq('10" Pizza')
  end
end
