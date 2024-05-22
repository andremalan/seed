# frozen_string_literal: true

module Mutations
  module SectionItemMutations
    class AddItemToSection < Mutations::BaseMutation
      argument :section_id, ID, required: true
      argument :item_id, ID, required: true
      argument :display_order, Integer, required: true

      field :section, Types::SectionType, null: false

      def resolve(section_id:, item_id:, display_order:)
        section_item = SectionItem.create!(
          section_id:,
          item_id:,
          display_order:
        )
        { section_item: }
      end
    end

    class RemoveItemFromSection < Mutations::BaseMutation
      argument :section_id, ID, required: true
      argument :item_id, ID, required: true

      field :section, Types::SectionType, null: false

      def resolve(section_id:, item_id:)
        section_item = SectionItem.find_by!(section_id:, item_id:)
        section_item.destroy
        { section: Section.find(section_id) }
      end
    end
  end
end
