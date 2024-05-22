# frozen_string_literal: true

FactoryBot.define do
  factory :menu do
    label { 'Menu Label' }
    state { 'active' }
    start_date { '2024-05-01' }
    end_date { '2024-12-31' }
  end
end
