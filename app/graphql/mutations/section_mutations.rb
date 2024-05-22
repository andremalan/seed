# frozen_string_literal: true

module Mutations
  module SectionMutations
    class CreateSection < Mutations::BaseMutation
      argument :label, String, required: true
      argument :description, String, required: true

      field :section, Types::SectionType, null: false

      def resolve(label:, description:)
        section = Section.create!(
          label:,
          description:
        )
        { section: }
      end
    end

    class UpdateSection < Mutations::BaseMutation
      argument :identifier, ID, required: true
      argument :label, String, required: false
      argument :description, String, required: false

      field :section, Types::SectionType, null: false

      def resolve(identifier:, **attributes)
        section = Section.find(identifier)
        section.update!(attributes)
        { section: }
      end
    end

    class DeleteSection < Mutations::BaseMutation
      argument :identifier, ID, required: true

      field :section, Types::SectionType, null: false

      def resolve(identifier:)
        section = Section.find(identifier)
        section.destroy
        { section: }
      end
    end
  end
end
