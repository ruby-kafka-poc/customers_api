# frozen_string_literal: true

class OrganizationAssociation < ApplicationRecord
  include AASM

  validates :state, presence: true

  belongs_to :organization
  belongs_to :customer

  aasm column: :state do
    state :pending, initial: true
    state :rejected
    state :ready

    event :accepted do
      transitions from: :pending, to: :ready
    end

    event :rejected do
      transitions from: :pending, to: :rejected
    end
  end
end
