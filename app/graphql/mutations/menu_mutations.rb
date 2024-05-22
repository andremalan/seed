# frozen_string_literal: true

module Mutations
  module MenuMutations
    class CreateMenu < Mutations::BaseMutation
      argument :label, String, required: true
      argument :state, String, required: true
      argument :start_date, GraphQL::Types::ISO8601Date, required: true
      argument :end_date, GraphQL::Types::ISO8601Date, required: true

      field :menu, Types::MenuType, null: false

      def resolve(label:, state:, start_date:, end_date:)
        menu = Menu.create!(
          label:,
          state:,
          start_date:,
          end_date:
        )
        { menu: }
      end
    end

    class UpdateMenu < Mutations::BaseMutation
      argument :identifier, ID, required: true
      argument :label, String, required: false
      argument :state, String, required: false
      argument :start_date, GraphQL::Types::ISO8601Date, required: false
      argument :end_date, GraphQL::Types::ISO8601Date, required: false

      field :menu, Types::MenuType, null: false

      def resolve(identifier:, **attributes)
        menu = Menu.find(identifier)
        menu.update!(attributes)
        { menu: }
      end
    end

    class DeleteMenu < Mutations::BaseMutation
      argument :identifier, ID, required: true

      field :menu, Types::MenuType, null: false

      def resolve(identifier:)
        menu = Menu.find(identifier)
        menu.destroy
        { menu: }
      end
    end
  end
end
