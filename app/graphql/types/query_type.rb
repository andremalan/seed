# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :identifier, ID, required: true, description: 'ID of the object.'
    end

    def node(identifier:)
      context.schema.object_from_id(identifier, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true,
                                                     description: 'Fetches a list of objects given a list of IDs.' do
      argument :identifiers, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(identifiers:)
      identifiers.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :menus, [Types::MenuType], null: false do
      description 'Retrieve all menus'
    end

    field :menu, Types::MenuType, null: false do
      description 'Retrieve a menu by identifier'
      argument :identifier, ID, required: true
    end

    def menus
      Menu.all
    end

    def menu(identifier:)
      Menu.find(identifier)
    end
  end
end
