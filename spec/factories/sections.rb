# frozen_string_literal: true

FactoryBot.define do
  factory :section do
    label { 'Section Label' }
    description { 'Section Description' }
    available { true }
  end
end
