# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrganizationAssociationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/organizations/1/invites').to route_to('organization_associations#index', organization_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/organizations/1/invites').to route_to('organization_associations#create', organization_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/organizations/1/invites/5').to route_to(
        'organization_associations#destroy', id: '5', organization_id: '1'
      )
    end
  end
end
