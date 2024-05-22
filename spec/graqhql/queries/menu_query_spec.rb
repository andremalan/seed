# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphQL Queries', type: :request do
  describe 'menu query' do
    let!(:menu) do
      create(:menu, label: 'Pizza Menu', state: 'active', start_date: '2024-05-01', end_date: '2024-12-31')
    end
    let!(:section) { create(:section, label: 'Classic Pizzas', description: 'Traditional Italian pizzas.') }
    let!(:item) do
      create(:item, label: 'Margherita Pizza',
                    description: 'Classic pizza with tomatoes, mozzarella cheese, and fresh basil.', price: 800, type: 'Product')
    end
    let!(:modifier_group) do
      create(:modifier_group, label: 'Pizza Size', selection_required_min: 1, selection_required_max: 1)
    end
    let!(:modifier) do
      create(:modifier, item:, modifier_group:, display_order: 1, default_quantity: 1, price_override: 0)
    end

    before do
      create(:menu_section, menu:, section:, display_order: 1)
      create(:section_item, section:, item:, display_order: 1)
      create(:item_modifier_group, item:, modifier_group:)
    end

    it 'returns the full menu with sections, items, and modifiers' do
      query = <<-GRAPHQL
        query {
          menu(identifier: #{menu.id}) {
            identifier
            label
            sections {
              identifier
              label
              items {
                identifier
                label
                description
                price
                type
                modifierGroups {
                  identifier
                  label
                  modifiers {
                    identifier
                    defaultQuantity
                    priceOverride
                  }
                }
              }
            }
          }
        }
      GRAPHQL

      result = execute_query(query)

      expect(result.dig('data', 'menu', 'label')).to eq('Pizza Menu')
      expect(result.dig('data', 'menu', 'sections').first['label']).to eq('Classic Pizzas')
      expect(result.dig('data', 'menu', 'sections').first['items'].first['label']).to eq('Margherita Pizza')
      expect(result.dig('data', 'menu',
                        'sections').first['items'].first['modifierGroups'].first['label']).to eq('Pizza Size')
      expect(result.dig('data', 'menu',
                        'sections').first['items'].first['modifierGroups'].first['modifiers'].first['defaultQuantity']).to eq(1)
    end
  end
end
