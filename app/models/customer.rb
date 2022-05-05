# frozen_string_literal: true

class Customer < ApplicationRecord
  include Eventeable

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
