# frozen_string_literal: true

class Organization < ApplicationRecord
  include KafkaRailsIntegration::Concerns::Model::Eventeable

  validates :name, presence: true
end
