# frozen_string_literal: true

FactoryBot.define do
  factory :modifier do
    association :item
    association :modifier_group
    display_order { 1 }
    default_quantity { 1 }
    price_override { 0 }
  end
end
