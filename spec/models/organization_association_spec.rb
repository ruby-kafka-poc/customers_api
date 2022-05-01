# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrganizationAssociation, type: :model do
  let(:organization) { FactoryBot.create(:organization) }
  let(:customer) { FactoryBot.create(:customer) }
  let(:association) { OrganizationAssociation.new }

  it 'is valid with valid attributes' do
    association.assign_attributes(
      organization:,
      customer:
    )
    expect(association.valid?).to be_truthy
    expect(association.state).to eq('pending')
  end

  it 'is not valid without an customer' do
    association.assign_attributes(
      organization:
    )
    expect(association.valid?).to be_falsey
    expect(association.errors.full_messages).to include("Customer can't be blank")
  end

  it 'is not valid without a organization' do
    association.assign_attributes(
      customer:
    )
    expect(association.valid?).to be_falsey
    expect(association.errors.full_messages).to include("Organization can't be blank")
  end
end
