# frozen_string_literal: true

module GraphQLHelper
  def execute_query(query, variables = {})
    SeedSchema.execute(query, variables:)
  end
end
