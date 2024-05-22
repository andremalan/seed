# frozen_string_literal: true

FactoryBot.define do
  factory :section_item do
    association :section
    association :item
    display_order { 1 }
  end
end
