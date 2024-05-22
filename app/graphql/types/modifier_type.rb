# frozen_string_literal: true

module Types
  class ModifierType < Types::BaseObject
    field :identifier, ID, null: false
    field :item_id, Integer, null: false
    field :modifier_group_id, Integer, null: false
    field :display_order, Integer, null: false
    field :default_quantity, Integer, null: false
    field :price_override, Integer, null: true

    def identifier
      object.id
    end
  end
end
