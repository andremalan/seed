# frozen_string_literal: true

module Types
  class MenuType < Types::BaseObject
    field :identifier, ID, null: false
    field :label, String, null: false
    field :state, String, null: false
    field :start_date, GraphQL::Types::ISO8601Date, null: false
    field :end_date, GraphQL::Types::ISO8601Date, null: false
    field :sections, [Types::SectionType], null: false

    def identifier
      object.id
    end
  end
end
