# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/organizations/:organization_id/invite', type: :request do
  let(:organization) { FactoryBot.create(:organization) }
  let(:customer) { FactoryBot.create(:customer) }
  let(:association) { FactoryBot.create(:organization_association) }

  let(:valid_attributes) do
    {
      customer_id: customer.id
    }
  end

  let(:invalid_attributes) do
    {
      customer_id: nil
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

  describe 'GET /index' do
    before { FactoryBot.create_list(:organization_association, 3) }

    it 'renders a successful response' do
      get organization_organization_associations_url(organization), headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).count).to eq(3)
    end
  end

  describe 'POST /invite' do
    context 'with valid parameters' do
      it 'creates a new Invite' do
        expect do
          post organization_organization_associations_url(organization),
               params: { invite: valid_attributes }, headers: valid_headers, as: :json
        end.to change(OrganizationAssociation, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new OrganizationAssociation' do
        expect do
          post organization_organization_associations_url(organization),
               params: { invite: invalid_attributes }, as: :json
        end.to change(Customer, :count).by(0)
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
