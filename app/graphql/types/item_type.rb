# frozen_string_literal: true

module Types
  class ItemType < Types::BaseObject
    field :identifier, ID, null: false
    field :label, String, null: false
    field :description, String, null: false
    field :price, Integer, null: false
    field :type, String, null: false
    field :available, Boolean, null: false
    field :img, String
    field :modifier_groups, [Types::ModifierGroupType], null: false

    def identifier
      object.id
    end
  end
end
