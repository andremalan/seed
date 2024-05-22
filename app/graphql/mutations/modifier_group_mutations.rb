# frozen_string_literal: true

module Mutations
  module ModifierGroupMutations
    class CreateModifierGroup < Mutations::BaseMutation
      argument :label, String, required: true
      argument :selection_required_min, Integer, required: true
      argument :selection_required_max, Integer, required: true

      field :modifier_group, Types::ModifierGroupType, null: false

      def resolve(label:, selection_required_min:, selection_required_max:)
        modifier_group = ModifierGroup.create!(
          label:,
          selection_required_min:,
          selection_required_max:
        )
        { modifier_group: }
      end
    end

    class UpdateModifierGroup < Mutations::BaseMutation
      argument :identifier, ID, required: true
      argument :label, String, required: false
      argument :selection_required_min, Integer, required: false
      argument :selection_required_max, Integer, required: false

      field :modifier_group, Types::ModifierGroupType, null: false

      def resolve(identifier:, **attributes)
        modifier_group = ModifierGroup.find(identifier)
        modifier_group.update!(attributes)
        { modifier_group: }
      end
    end

    class DeleteModifierGroup < Mutations::BaseMutation
      argument :identifier, ID, required: true

      field :modifier_group, Types::ModifierGroupType, null: false

      def resolve(identifier:)
        modifier_group = ModifierGroup.find(identifier)
        modifier_group.destroy
        { modifier_group: }
      end
    end
  end
end
