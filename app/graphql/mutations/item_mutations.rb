# frozen_string_literal: true

module Mutations
  module ItemMutations
    class CreateItem < Mutations::BaseMutation
      argument :label, String, required: true
      argument :description, String, required: true
      argument :price, Integer, required: true
      argument :type, String, required: true

      field :item, Types::ItemType, null: false

      def resolve(label:, description:, price:, type:)
        item = Item.create!(
          label:,
          description:,
          price:,
          type:
        )
        { item: }
      end
    end

    class UpdateItem < Mutations::BaseMutation
      argument :identifier, ID, required: true
      argument :label, String, required: false
      argument :description, String, required: false
      argument :price, Integer, required: false
      argument :type, String, required: false

      field :item, Types::ItemType, null: false

      def resolve(identifier:, **attributes)
        item = Item.find(identifier)
        item.update!(attributes)
        { item: }
      end
    end

    class DeleteItem < Mutations::BaseMutation
      argument :identifier, ID, required: true

      field :item, Types::ItemType, null: false

      def resolve(identifier:)
        item = Item.find(identifier)
        item.destroy
        { item: }
      end
    end
  end
end
