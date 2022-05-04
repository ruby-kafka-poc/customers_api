# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.before(:example) do
    allow(Kafka::Producer).to receive(:produce)
    allow(Kafka::Producer).to receive(:deliver!)
  end
end
