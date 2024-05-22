# frozen_string_literal: true

# Clear existing data
MenuSection.delete_all
SectionItem.delete_all
ItemModifierGroup.delete_all
Modifier.delete_all
ModifierGroup.delete_all
Item.delete_all
Section.delete_all
Menu.delete_all

# Create Menus
menu1 = Menu.create!(label: 'Pizza Menu', state: 'active', start_date: '2024-05-01', end_date: '2024-12-31')
menu2 = Menu.create!(label: 'Drinks Menu', state: 'active', start_date: '2024-05-01', end_date: '2024-12-31')

# Create Sections
section1 = Section.create!(label: 'Classic Pizzas',
                           description: 'Traditional Italian pizzas with a variety of toppings.')
section2 = Section.create!(label: 'Specialty Pizzas',
                           description: 'Unique and gourmet pizzas with special ingredients.')
section3 = Section.create!(label: 'Beverages', description: 'A selection of soft drinks, juices, and other beverages.')

# Create MenuSections
MenuSection.create!(menu: menu1, section: section1, display_order: 1)
MenuSection.create!(menu: menu1, section: section2, display_order: 2)
MenuSection.create!(menu: menu2, section: section3, display_order: 1)

# Create Items
item1 = Item.create!(label: 'Margherita Pizza',
                     description: 'Classic pizza with tomatoes, mozzarella cheese, and fresh basil.', price: 800, type: 'Product')
item2 = Item.create!(label: 'Pepperoni Pizza',
                     description: 'Delicious pizza topped with pepperoni slices and mozzarella cheese.', price: 900, type: 'Product')
item3 = Item.create!(label: 'Coke', description: 'Refreshing Coca-Cola beverage.', price: 200, type: 'Product')
item4 = Item.create!(label: 'Sprite', description: 'Refreshing Sprite beverage.', price: 200, type: 'Product')

# Create SectionItems
SectionItem.create!(section: section1, item: item1, display_order: 1)
SectionItem.create!(section: section1, item: item2, display_order: 2)
SectionItem.create!(section: section3, item: item3, display_order: 1)
SectionItem.create!(section: section3, item: item4, display_order: 2)

# Create ModifierGroups
modifier_group1 = ModifierGroup.create!(label: 'Pizza Size', selection_required_min: 1, selection_required_max: 1)
modifier_group2 = ModifierGroup.create!(label: 'Extra Toppings', selection_required_min: 0, selection_required_max: 3)

# Create ItemModifierGroups
ItemModifierGroup.create!(item: item1, modifier_group: modifier_group1)
ItemModifierGroup.create!(item: item1, modifier_group: modifier_group2)
ItemModifierGroup.create!(item: item2, modifier_group: modifier_group1)
ItemModifierGroup.create!(item: item2, modifier_group: modifier_group2)

# Create Modifiers
modifier1 = Modifier.create!(item: item1, modifier_group: modifier_group1, display_order: 1, default_quantity: 1,
                             price_override: 0)
modifier2 = Modifier.create!(item: item2, modifier_group: modifier_group1, display_order: 2, default_quantity: 1,
                             price_override: 0)

modifier3 = Modifier.create!(item: item1, modifier_group: modifier_group2, display_order: 1, default_quantity: 0,
                             price_override: 100)
modifier4 = Modifier.create!(item: item2, modifier_group: modifier_group2, display_order: 2, default_quantity: 0,
                             price_override: 150)

# Create Modifier Items (these are the actual components/options)
modifier_item1 = Item.create!(label: '10" Pizza', description: 'Small 10 inch pizza', price: 800, type: 'Component')
modifier_item2 = Item.create!(label: '12" Pizza', description: 'Medium 12 inch pizza', price: 900, type: 'Component')
modifier_item3 = Item.create!(label: 'Extra Cheese', description: 'Add extra cheese', price: 100, type: 'Component')
modifier_item4 = Item.create!(label: 'Pepperoni', description: 'Add pepperoni', price: 150, type: 'Component')

# Associate Modifiers with their component items
modifier1.update(item: modifier_item1)
modifier2.update(item: modifier_item2)
modifier3.update(item: modifier_item3)
modifier4.update(item: modifier_item4)

puts 'Seeding completed successfully!'
