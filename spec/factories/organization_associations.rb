# frozen_string_literal: true

FactoryBot.define do
  factory :organization_association do
    organization
    customer

    state { 'pending' }
  end
end
