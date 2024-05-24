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

    field :sections, [Types::SectionType], null: false do
      description 'Retrieve all sections'
    end

    field :section, Types::SectionType, null: false do
      description 'Retrieve a section by identifier'
      argument :identifier, ID, required: true
    end

    field :items, [Types::ItemType], null: false do
      description 'Retrieve all items'
    end

    field :item, Types::ItemType, null: false do
      description 'Retrieve an item by identifier'
      argument :identifier, ID, required: true
    end

    def menus
      Menu.all
    end

    def menu(identifier:)
      Menu.find(identifier)
    end

    def sections
      Section.all
    end

    def section(identifier:)
      Section.find(identifier)
    end

    def items
      Item.all
    end

    def item(identifier:)
      Item.find(identifier)
    end
  end
end
