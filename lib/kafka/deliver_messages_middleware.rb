# frozen_string_literal: true

module Kafka
  class DeliverMessagesMiddleware
    def initialize(app)
      @app = app
    end

    # Flush to Kafka all messages after request end
    def call(env)
      @app.call(env)
    ensure
      Kafka::Producer.deliver!
    end
  end
end
