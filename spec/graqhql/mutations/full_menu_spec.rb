# frozen_string_literal: true

# spec/graphql/mutations/create_full_menu_spec.rb
require 'rails_helper'

RSpec.describe 'GraphQL Mutations', type: :request do
  describe 'createFullMenu mutation' do
    it 'creates a full menu with sections, items, and modifiers' do
      mutation = <<-GRAPHQL
        mutation {
          createMenu(input: { label: "Pizza Menu", state: "active", startDate: "2024-05-01", endDate: "2024-12-31" }) {
            menu {
              identifier
              label
              state
              startDate
              endDate
            }
          }
          createSection(input: { label: "Classic Pizzas", description: "Traditional Italian pizzas." }) {
            section {
              identifier
              label
            }
          }
          createItem(input: { label: "Margherita Pizza", description: "Classic pizza with tomatoes, mozzarella cheese, and fresh basil.", price: 800, type: "Product" }) {
            item {
              identifier
              label
            }
          }
          addSectionToMenu(input: { menuId: 1, sectionId: 1, displayOrder: 1 }) {
            menu {
              identifier
              label
              sections {
                identifier
                label
              }
            }
          }
          addItemToSection(input: { sectionId: 1, itemId: 1, displayOrder: 1 }) {
            section {
              identifier
              label
              items {
                identifier
                label
              }
            }
          }
          createModifierGroup(input: { label: "Pizza Size", selectionRequiredMin: 1, selectionRequiredMax: 1 }) {
            modifierGroup {
              identifier
              label
            }
          }
          addModifierGroupToItem(input: { itemId: 1, modifierGroupId: 1 }) {
            item {
              identifier
              label
              modifierGroups {
                identifier
                label
              }
            }
          }
          createModifier(input: { itemId: 1, modifierGroupId: 1, displayOrder: 1, defaultQuantity: 1, priceOverride: 0 }) {
            modifier {
              identifier
              defaultQuantity
              priceOverride
            }
          }
        }
      GRAPHQL

      result = execute_query(mutation)
      expect(result.dig('data', 'createMenu', 'menu', 'label')).to eq('Pizza Menu')
      expect(result.dig('data', 'createSection', 'section', 'label')).to eq('Classic Pizzas')
      expect(result.dig('data', 'createItem', 'item', 'label')).to eq('Margherita Pizza')
      expect(result.dig('data', 'createModifierGroup', 'modifierGroup', 'label')).to eq('Pizza Size')
      expect(result.dig('data', 'createModifier', 'modifier', 'defaultQuantity')).to eq(1)

      menu_id = result.dig('data', 'createModifier', 'modifier', 'identifier')
      # Query the created menu to verify its structure and data
      query = <<-GRAPHQL
        query {
          menu(identifier: #{menu_id}) {
            identifier
            label
            startDate
            endDate
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
