# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    label { 'Item Label' }
    description { 'Item Description' }
    available { true }
    img { 'https://via.placeholder.com/150' }
    price { 1000 }
    type { 'Product' }
  end
end
