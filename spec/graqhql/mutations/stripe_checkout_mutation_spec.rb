# frozen_string_literal: true

# spec/graphql/mutations/create_checkout_session_mutation_spec.rb
require 'rails_helper'
require 'stripe_mock'

RSpec.describe Mutations::CreateCheckoutSessionMutation, type: :request do
  let(:line_items) do
    [
      { label: 'Item 1', price: 1000, quantity: 1 },
      { label: 'Item 2', price: 2000, quantity: 2 }
    ]
  end
  let(:success_url) { 'https://example.com/success' }
  let(:cancel_url) { 'https://example.com/cancel' }

  let(:query) do
    <<~GQL
      mutation {
        createCheckoutSession(input: {
          lineItems: [
            { label: "Item 1", price: 1000, quantity: 1 },
            { label: "Item 2", price: 2000, quantity: 2 }
          ],
          successUrl: "#{success_url}",
          cancelUrl: "#{cancel_url}"
        }) {
          sessionId
          url
        }
      }
    GQL
  end

  before { StripeMock.start }
  after { StripeMock.stop }

  it 'creates a Stripe Checkout Session' do
    post '/graphql', params: { query: }

    json = JSON.parse(response.body)
    data = json['data']['createCheckoutSession']

    expect(data['sessionId']).to be_present
    expect(data['url']).to be_present
  end

  it 'returns an error for invalid input' do
    invalid_query = <<~GQL
      mutation {
        createCheckoutSession(input: {
          lineItems: [
            { label: "Invalid Item", price: -1000, quantity: 1 }
          ],
          successUrl: "#{success_url}",
          cancelUrl: "#{cancel_url}"
        }) {
          sessionId
          url
        }
      }
    GQL

    post '/graphql', params: { query: invalid_query }

    json = JSON.parse(response.body)
    errors = json['errors']

    expect(errors).to be_present
  end
end
