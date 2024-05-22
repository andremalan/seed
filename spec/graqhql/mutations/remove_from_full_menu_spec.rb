# frozen_string_literal: true

# spec/graphql/mutations/remove_from_full_menu_spec.rb
require 'rails_helper'

RSpec.describe 'GraphQL Mutations', type: :request do
  describe 'removeFromFullMenu mutation' do
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

    it 'removes one modifier, one item, and one section from a full menu' do
      mutation = <<-GRAPHQL
        mutation {
          deleteModifier(input: { identifier: #{modifier.id} }) {
            modifier {
              identifier
            }
          }
          removeItemFromSection(input: { sectionId: #{section.id}, itemId: #{item.id} }) {
            section {
              identifier
              items {
                identifier
                label
              }
            }
          }
          removeSectionFromMenu(input: { menuId: #{menu.id}, sectionId: #{section.id} }) {
            menu {
              identifier
              sections {
                identifier
                label
              }
            }
          }
        }
      GRAPHQL
      result = execute_query(mutation)
      expect(result.dig('data', 'deleteModifier', 'modifier', 'identifier')).to eq(modifier.id.to_s)
      expect(result.dig('data', 'removeItemFromSection', 'section', 'items')).to be_empty
      expect(result.dig('data', 'removeSectionFromMenu', 'menu', 'sections')).to be_empty
    end
  end
end
