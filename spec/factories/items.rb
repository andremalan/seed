# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    label { 'Item Label' }
    description { 'Item Description' }
    price { 1000 }
    type { 'Product' }
  end
end
