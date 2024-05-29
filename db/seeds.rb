# frozen_string_literal: true

# Clear existing data
SectionItem.delete_all
ItemModifierGroup.delete_all
MenuSection.delete_all
Modifier.delete_all
ModifierGroup.delete_all
Item.delete_all
Section.delete_all
Menu.delete_all

food = Menu.create!(
  label: 'Food',
  state: 'active',
  start_date: Date.today,
  end_date: Date.today + 1.month
)

drinks_menu = Menu.create!(
  label: 'Drinks',
  state: 'active',
  start_date: Date.today,
  end_date: Date.today + 1.month
)

# Define common modifiers
size_modifier_group = ModifierGroup.create!(
  label: 'Pizza Size',
  selection_required_min: 1,
  selection_required_max: 1
)

extra_toppings_modifier_group = ModifierGroup.create!(
  label: 'Extra Toppings',
  selection_required_min: 0,
  selection_required_max: 5
)

# Create size modifiers
sizes = %w[Small Medium Large]
sizes.each_with_index do |size, index|
  size_item = Item.create!(
    label: size,
    description: "A #{size.downcase} pizza, perfect for one person.",
    price: 1000 + index * 200, # Assume Small: 1000 cents, Medium: 1200 cents, Large: 1400 cents
    type: 'Modifier',
    available: true
  )

  Modifier.create!(
    label: size,
    item: size_item,
    modifier_group: size_modifier_group,
    display_order: index + 1,
    default_quantity: 0,
    price_override: index * 200 # Assume Small: 0, Medium: 200 cents, Large: 400 cents
  )
end

# Create extra toppings modifiers
extra_toppings = ['Extra Cheese', 'Pepperoni', 'Mushrooms', 'Onions', 'Green Peppers']
extra_toppings.each_with_index do |topping, index|
  topping_item = Item.create!(
    label: topping,
    description: "Add extra #{topping.downcase} to your pizza.",
    price: 100, # Assume each extra topping costs 100 cents
    type: 'Modifier',
    available: true
  )

  Modifier.create!(
    label: topping,
    item: topping_item,
    modifier_group: extra_toppings_modifier_group,
    display_order: index + 1,
    default_quantity: 0,
    price_override: 100 # Assume each extra topping costs 100 cents
  )
end

# Create sections
classic_pizzas = Section.create!(
  label: 'Classic Pizzas',
  description: 'A selection of traditional Italian pizzas.',
  available: true
)

special_pizzas = Section.create!(
  label: 'Specialty Pizzas',
  description: 'Unique and gourmet pizza options.',
  available: true
)

pastas = Section.create!(
  label: 'Pastas',
  description: 'A variety of delicious pasta dishes.',
  available: false
)

beverages = Section.create!(
  label: 'Beverages',
  description: 'Refreshing drinks to accompany your meal.',
  available: true
)

MenuSection.create!(menu: food, section: classic_pizzas, display_order: 1)
MenuSection.create!(menu: food, section: special_pizzas, display_order: 2)
MenuSection.create!(menu: food, section: pastas, display_order: 3)
MenuSection.create!(menu: drinks_menu, section: beverages, display_order: 4)

# Create Classic Pizzas
classic_pizza_descriptions = [
  'Margherita: A delightful pizza topped with fresh tomatoes, mozzarella cheese, and basil leaves. The perfect choice for a traditional pizza lover.',
  'Meat Feast: A savory blend of Italian sausage, pepperoni, and ham, combined with our signature tomato sauce and mozzarella cheese.',
  'Vegetarian: A flavorful pizza featuring a mix of fresh mushrooms, onions, and green peppers, layered with mozzarella cheese.',
  'Cheese Lover: A classic pizza with a crispy crust, topped with a rich tomato sauce, mozzarella cheese, and fresh oregano.',
  'Spicy Pepperoni: A zesty pizza with spicy pepperoni, jalapenos, and a sprinkle of red pepper flakes, finished with mozzarella cheese.',
  'White Spinach: A gourmet pizza with a base of white sauce, topped with spinach, artichoke hearts, and mozzarella cheese.',
  "Garden Veggie: A vegetarian's dream, loaded with a variety of fresh vegetables and topped with mozzarella cheese.",
  'BBQ Chicken: A delicious pizza with a combination of BBQ chicken, red onions, and cilantro, all smothered in mozzarella cheese.',
  'Hawaiian: A Hawaiian favorite, topped with ham, pineapple, and mozzarella cheese.',
  'Mediterranean: A Mediterranean-inspired pizza with feta cheese, olives, tomatoes, and fresh spinach.',
  'Extra Cheese: A simple yet delicious pizza with extra cheese and a perfect blend of herbs.',
  'Beefy Delight: A hearty pizza with ground beef, onions, and a mix of cheddar and mozzarella cheeses.',
  "Seafood Special: A seafood lover's delight, topped with shrimp, crab, and a light garlic sauce.",
  'Spicy Chorizo: A spicy pizza with chorizo, jalapenos, and a drizzle of hot sauce, topped with mozzarella cheese.',
  'Prosciutto Arugula: A unique pizza with prosciutto, arugula, and a drizzle of balsamic glaze, finished with mozzarella cheese.'
]

classic_pizza_descriptions.each_with_index do |description, index|
  name, full_description = description.split(': ', 2)
  item = Item.create!(
    label: name,
    description: full_description,
    price: 1000 + index * 50, # Prices vary slightly
    type: 'Product',
    available: index >= 4,
    img: "https://picsum.photos/600?random=#{index}"
  )
  SectionItem.create!(section: classic_pizzas, item:, display_order: index + 1)

  item.modifier_groups << size_modifier_group
  item.modifier_groups << extra_toppings_modifier_group
end

# Create Specialty Pizzas
special_pizza_descriptions = [
  'Truffle Mushroom: A pizza like no other, topped with truffle oil, wild mushrooms, and a blend of exotic cheeses.',
  'Tandoori Chicken: A fusion pizza with tandoori chicken, red onions, and a drizzle of mint chutney.',
  "Smoked Salmon: A seafood lover's delight, featuring smoked salmon, capers, and a light dill sauce.",
  'Fig Prosciutto: A gourmet pizza with a base of fig jam, topped with prosciutto, goat cheese, and arugula.',
  'Buffalo Chicken: A unique pizza with a spicy buffalo chicken topping, blue cheese crumbles, and a ranch drizzle.'
]

special_pizza_descriptions.each_with_index do |description, index|
  name, full_description = description.split(': ', 2)
  item = Item.create!(
    label: name,
    description: full_description,
    price: 1500 + index * 100, # Prices vary slightly
    type: 'Product',
    available: true,
    img: "https://picsum.photos/600?random=#{index + 15}"
  )
  SectionItem.create!(section: special_pizzas, item:, display_order: index + 1)

  item.modifier_groups << size_modifier_group
  item.modifier_groups << extra_toppings_modifier_group
end

# Create Pastas
pasta_descriptions = [
  'Spaghetti Marinara: A classic spaghetti dish with a rich tomato sauce, fresh basil, and a sprinkle of Parmesan cheese.',
  'Chicken Alfredo: A creamy Alfredo pasta with tender chicken pieces and a garnish of parsley.',
  'Beef Bolognese: A delicious pasta with a hearty Bolognese sauce, made with ground beef and a blend of Italian herbs.',
  'Vegetable Primavera: A vegetarian pasta with a mix of grilled vegetables, tossed in a light olive oil and garlic sauce.',
  'Seafood Pasta: A seafood pasta with a light white wine sauce, featuring shrimp, scallops, and fresh parsley.'
]

pasta_descriptions.each_with_index do |description, index|
  name, full_description = description.split(': ', 2)
  item = Item.create!(
    label: name,
    description: full_description,
    price: 1200 + index * 50, # Prices vary slightly
    type: 'Product',
    available: false,
    img: "https://picsum.photos/600?random=#{index + 20}"
  )
  SectionItem.create!(section: pastas, item:, display_order: index + 1)
end

# Create Beverages
beverage_descriptions = [
  'Cola: A refreshing cola drink, perfect for quenching your thirst.',
  'Lemon-Lime Soda: A crisp and cool lemon-lime soda, great with any meal.',
  'Iced Tea: A classic iced tea, brewed to perfection and served chilled.',
  'Sparkling Water: A sparkling water with a hint of lime, a refreshing choice.',
  'Chocolate Milkshake: A rich and creamy chocolate milkshake, a treat for any time of the day.'
]

beverage_descriptions.each_with_index do |description, index|
  name, full_description = description.split(': ', 2)
  item = Item.create!(
    label: name,
    description: full_description,
    price: 300 + index * 50, # Prices vary slightly
    type: 'Product',
    available: true,
    img: "https://picsum.photos/600?random=#{index + 25}"
  )
  SectionItem.create!(section: beverages, item:, display_order: index + 1)
end

puts 'Seeding complete!'
