# frozen_string_literal: true

module Types
  class SectionType < Types::BaseObject
    field :identifier, ID, null: false
    field :label, String, null: false
    field :description, String, null: false
    field :items, [Types::ItemType], null: false

    def identifier
      object.id
    end
  end
end
