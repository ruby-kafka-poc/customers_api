# frozen_string_literal: true

require 'json'

module Kafka
  class Producer
    # Send payload to Kafka
    #
    # @param payload [Object] Hash will dump to string. any other `#to_s`
    #
    # @param topic [String] kafka topic name.
    def self.produce(payload, topic = 'default')
      payload = payload.is_a?(Hash) ? JSON.dump(payload) : payload.to_s
      client.producer.produce(payload, topic: topic.underscore)
      # client.each_message(topic: topic) { |m| puts m.offset, m.key, m.value}
      @dirty = true
    end

    # Flush messages to Kafka
    def self.deliver!
      return unless  @dirty

      client.producer.deliver_messages
      @dirty = false
    end

    def self.client
      @client ||= Kafka.new(['localhost:9092'], client_id: 'customer_api')
    end
  end
end
