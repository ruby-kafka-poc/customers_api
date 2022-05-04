# frozen_string_literal: true

module Kafka
  class DeliverMessagesMiddleware
    VERBS = %w[POST PATCH PUT]

    def initialize(app)
      @app = app
    end

    # Flush to Kafka all messages after request end
    def call(env)
      @app.call(env)
    ensure
      Kafka::Producer.deliver! if VERBS.include?(env[Rack::REQUEST_METHOD])
    end
  end
end
