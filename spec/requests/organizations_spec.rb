# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/organizations', type: :request do
  let(:valid_attributes) do
    {
      name: Faker::Company.name
    }
  end

  let(:invalid_attributes) do
    {
      name: ''
    }
  end

  # TODO: add auth
  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # OrganizationsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) do
    {}
  end

  let(:organization) { FactoryBot.create(:organization) }

  describe 'GET /index' do
    before { FactoryBot.create_list(:organization, 3) }

    it 'renders a successful response' do
      get organizations_url, headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).count).to eq(3)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get organization_url(organization), as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)['name']).to eq(organization.name)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Organization' do
        expect do
          post organizations_url,
               params: { organization: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Organization, :count).by(1)
      end

      it 'renders a JSON response with the new organization' do
        post organizations_url,
             params: { organization: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Organization' do
        expect do
          post organizations_url,
               params: { organization: invalid_attributes }, as: :json
        end.to change(Organization, :count).by(0)
      end

      it 'renders a JSON response with errors for the new organization' do
        post organizations_url,
             params: { organization: invalid_attributes }, headers: valid_headers, as: :json
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

      it 'updates the requested organization' do
        patch organization_url(organization),
              params: { organization: new_attributes }, headers: valid_headers, as: :json
        expect(organization.reload.name).to eq('Edited')
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the organization' do
        patch organization_url(organization),
              params: { organization: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested organization' do
      delete organization_url(organization.id), headers: valid_headers, as: :json
      expect(Organization.all.count).to eq(0)
    end
  end
end
