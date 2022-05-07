# frozen_string_literal: true

require 'kafka_rails_integration'

class Customer < ApplicationRecord
  include KafkaRailsIntegration::Concerns::Model::Eventeable

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
