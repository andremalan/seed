# frozen_string_literal: true

module Mutations
  module ModifierMutations
    class CreateModifier < Mutations::BaseMutation
      argument :item_id, ID, required: true
      argument :modifier_group_id, ID, required: true
      argument :display_order, Integer, required: true
      argument :default_quantity, Integer, required: true
      argument :price_override, Integer, required: false

      field :modifier, Types::ModifierType, null: false

      def resolve(item_id:, modifier_group_id:, display_order:, default_quantity:, price_override: nil)
        modifier = Modifier.create!(
          item_id:,
          modifier_group_id:,
          display_order:,
          default_quantity:,
          price_override:
        )
        { modifier: }
      end
    end

    class UpdateModifier < Mutations::BaseMutation
      argument :identifier, ID, required: true
      argument :item_id, ID, required: false
      argument :modifier_group_id, ID, required: false
      argument :display_order, Integer, required: false
      argument :default_quantity, Integer, required: false
      argument :price_override, Integer, required: false

      field :modifier, Types::ModifierType, null: false

      def resolve(identifier:, **attributes)
        modifier = Modifier.find(identifier)
        modifier.update!(attributes)
        { modifier: }
      end
    end

    class DeleteModifier < Mutations::BaseMutation
      argument :identifier, ID, required: true

      field :modifier, Types::ModifierType, null: false

      def resolve(identifier:)
        modifier = Modifier.find(identifier)
        modifier.destroy
        { modifier: }
      end
    end
  end
end
