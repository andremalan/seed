# frozen_string_literal: true

module Mutations
  module MenuSectionMutations
    class AddSectionToMenu < Mutations::BaseMutation
      argument :menu_id, ID, required: true
      argument :section_id, ID, required: true
      argument :display_order, Integer, required: true

      field :menu, Types::MenuType, null: false

      def resolve(menu_id:, section_id:, display_order:)
        menu_section = MenuSection.create!(
          menu_id:,
          section_id:,
          display_order:
        )
        { menu_section: }
      end
    end

    class RemoveSectionFromMenu < Mutations::BaseMutation
      argument :menu_id, ID, required: true
      argument :section_id, ID, required: true

      field :menu, Types::MenuType, null: false

      def resolve(menu_id:, section_id:)
        menu_section = MenuSection.find_by!(menu_id:, section_id:)
        menu_section.destroy
        { menu: Menu.find(menu_id) }
      end
    end
  end
end
