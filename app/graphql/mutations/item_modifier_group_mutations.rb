# frozen_string_literal: true

module Mutations
  module ItemModifierGroupMutations
    class AddModifierGroupToItem < Mutations::BaseMutation
      argument :item_id, ID, required: true
      argument :modifier_group_id, ID, required: true

      field :item, Types::ItemType, null: false

      def resolve(item_id:, modifier_group_id:)
        item_modifier_group = ItemModifierGroup.create!(
          item_id:,
          modifier_group_id:
        )
        { item_modifier_group: }
      end
    end

    class RemoveModifierGroupFromItem < Mutations::BaseMutation
      argument :item_id, ID, required: true
      argument :modifier_group_id, ID, required: true

      field :item, Types::ItemType, null: false

      def resolve(item_id:, modifier_group_id:)
        item_modifier_group = ItemModifierGroup.find_by!(item_id:, modifier_group_id:)
        item_modifier_group.destroy
        { item: Item.find(item_id) }
      end
    end
  end
end
