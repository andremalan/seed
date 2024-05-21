module Types
  class ModifierGroupType < Types::BaseObject
    field :identifier, ID, null: false
    field :label, String, null: false
    field :selection_required_min, Integer, null: false
    field :selection_required_max, Integer, null: false
    field :modifiers, [Types::ModifierType], null: false

    def identifier
      object.id
    end
  end
end
