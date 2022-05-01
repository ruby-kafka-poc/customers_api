# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/customers', type: :request do
  let(:valid_attributes) do
    {
      name: Faker::Name.name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email
    }
  end

  let(:invalid_attributes) do
    {
      email: 'wrong.com'
    }
  end

  # TODO: add auth
  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # CustomersController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) do
    {}
  end

  let(:customer) { FactoryBot.create(:customer) }

  describe 'GET /index' do
    before { FactoryBot.create_list(:customer, 3) }

    it 'renders a successful response' do
      get customers_url, headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).count).to eq(3)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get customer_url(customer), as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)['name']).to eq(customer.name)
      expect(JSON.parse(response.body)['last_name']).to eq(customer.last_name)
      expect(JSON.parse(response.body)['email']).to eq(customer.email)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Customer' do
        expect do
          post customers_url,
               params: { customer: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Customer, :count).by(1)
      end

      it 'renders a JSON response with the new customer' do
        post customers_url,
             params: { customer: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Customer' do
        expect do
          post customers_url,
               params: { customer: invalid_attributes }, as: :json
        end.to change(Customer, :count).by(0)
      end

      it 'renders a JSON response with errors for the new customer' do
        post customers_url,
             params: { customer: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: 'Edited'
        }
      end

      it 'updates the requested customer' do
        patch customer_url(customer),
              params: { customer: new_attributes }, headers: valid_headers, as: :json
        expect(customer.reload.name).to eq('Edited')
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the customer' do
        patch customer_url(customer),
              params: { customer: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested customer' do
      delete customer_url(customer.id), headers: valid_headers, as: :json
      expect(Customer.all.count).to eq(0)
    end
  end
end
