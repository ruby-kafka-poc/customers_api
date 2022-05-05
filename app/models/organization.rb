# frozen_string_literal: true

class Organization < ApplicationRecord
  include Eventeable

  validates :name, presence: true
end
