# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organization, type: :model do
  let(:organization) { Organization.new }

  it 'is valid with valid attributes' do
    organization.assign_attributes(name: Faker::Company.name)
    expect(organization.valid?).to be_truthy
  end

  it 'is not valid without a name' do
    expect(organization.valid?).to be_falsey
    expect(organization.errors.full_messages).to include("Name can't be blank")
  end
end
