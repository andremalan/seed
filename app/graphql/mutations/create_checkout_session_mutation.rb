# frozen_string_literal: true

# app/graphql/mutations/create_checkout_session_mutation.rb
module Mutations
  class CreateCheckoutSessionMutation < Mutations::BaseMutation
    class LineItemInput < Types::BaseInputObject
      argument :price, Integer, required: true
      argument :label, String, required: true
      argument :quantity, Integer, required: true
    end

    argument :line_items, [LineItemInput], required: true
    argument :success_url, String, required: true
    argument :cancel_url, String, required: true

    field :session_id, String, null: false
    field :url, String, null: false

    def line_item_map(line_items)
      line_items.map do |item|
        {
          price_data: {
            currency: 'usd',
            unit_amount: item[:price],
            product_data: {
              name: item[:label]
            }
          },
          quantity: item[:quantity]
        }
      end
    end

    def resolve(line_items:, success_url:, cancel_url:)
      session = Stripe::Checkout::Session.create({
                                                   payment_method_types: ['card'],
                                                   line_items: line_item_map(line_items),
                                                   mode: 'payment',
                                                   success_url:,
                                                   cancel_url:
                                                 })

      {
        session_id: session.id,
        url: session.url
      }
    rescue Stripe::StripeError => e
      raise GraphQL::ExecutionError, e.message
    end
  end
end
