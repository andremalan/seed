# frozen_string_literal: true

# spec/graphql/mutations/create_full_menu_spec.rb
require 'rails_helper'

RSpec.describe 'GraphQL Mutations', type: :request do
  describe 'createFullMenu mutation' do
    it 'creates a full menu with sections, items, and modifiers and verifies the data' do
      # Step 1: Create Menu, Section, Item, and Modifier Group
      mutation = <<-GRAPHQL
        mutation {
          createMenu(input: { label: "Pizza Menu", state: "active", startDate: "2024-05-01", endDate: "2024-12-31" }) {
            menu {
              identifier
            }
          }
          createSection(input: { label: "Classic Pizzas", description: "Traditional Italian pizzas." }) {
            section {
              identifier
            }
          }
          createItem(input: { label: "Margherita Pizza", description: "Classic pizza with tomatoes, mozzarella cheese, and fresh basil.", price: 800, type: "Product" }) {
            item {
              identifier
            }
          }
          createModifierGroup(input: { label: "Pizza Size", selectionRequiredMin: 1, selectionRequiredMax: 1 }) {
            modifierGroup {
              identifier
            }
          }
        }
      GRAPHQL

      result = execute_query(mutation)
      menu_id = result.dig('data', 'createMenu', 'menu', 'identifier')
      section_id = result.dig('data', 'createSection', 'section', 'identifier')
      item_id = result.dig('data', 'createItem', 'item', 'identifier')
      modifier_group_id = result.dig('data', 'createModifierGroup', 'modifierGroup', 'identifier')

      expect(menu_id).not_to be_nil
      expect(section_id).not_to be_nil
      expect(item_id).not_to be_nil
      expect(modifier_group_id).not_to be_nil

      # Step 2: Associate Section with Menu, Item with Section, and Modifier Group with Item
      mutation = <<-GRAPHQL
        mutation {
          addSectionToMenu(input: { menuId: #{menu_id}, sectionId: #{section_id}, displayOrder: 1 }) {
            menu {
              identifier
              sections {
                identifier
                label
              }
            }
          }
          addItemToSection(input: { sectionId: #{section_id}, itemId: #{item_id}, displayOrder: 1 }) {
            section {
              identifier
              label
              items {
                identifier
                label
              }
            }
          }
          addModifierGroupToItem(input: { itemId: #{item_id}, modifierGroupId: #{modifier_group_id} }) {
            item {
              identifier
              label
              modifierGroups {
                identifier
                label
              }
            }
          }
          createModifier(input: { itemId: #{item_id}, modifierGroupId: #{modifier_group_id}, displayOrder: 1, defaultQuantity: 1, priceOverride: 0 }) {
            modifier {
              identifier
              defaultQuantity
              priceOverride
            }
          }
        }
      GRAPHQL
      result = execute_query(mutation)
      expect(result.dig('data', 'addSectionToMenu', 'menu', 'sections')).to be_nil
      expect(result.dig('data', 'addItemToSection', 'section', 'items')).to be_nil
      expect(result.dig('data', 'addModifierGroupToItem', 'item', 'modifierGroups')).to be_nil
      expect(result.dig('data', 'createModifier', 'modifier', 'defaultQuantity')).to eq(1)

      # Step 3: Update values of items and sections
      mutation = <<-GRAPHQL
        mutation {
          updateItem(input: { identifier: #{item_id}, price: 900 }) {
            item {
              identifier
              price
            }
          }
          updateSection(input: { identifier: #{section_id}, description: "Updated Description" }) {
            section {
              identifier
              description
            }
          }
        }
      GRAPHQL
      result = execute_query(mutation)

      expect(result.dig('data', 'updateItem', 'item', 'price')).to eq(900)
      expect(result.dig('data', 'updateSection', 'section', 'description')).to eq('Updated Description')

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
              description
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
      expect(result.dig('data', 'menu', 'sections').first['description']).to eq('Updated Description')
      expect(result.dig('data', 'menu', 'sections').first['items'].first['label']).to eq('Margherita Pizza')
      expect(result.dig('data', 'menu', 'sections').first['items'].first['price']).to eq(900)
      expect(result.dig('data', 'menu', 'sections').first['items'].first['modifierGroups'].first['label']).to eq('Pizza Size')
      expect(result.dig('data', 'menu', 'sections').first['items'].first['modifierGroups'].first['modifiers'].first['defaultQuantity']).to eq(1)
    end
  end
end
