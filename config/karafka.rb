# frozen_string_literal: true

# require ::File.expand_path('config/environment', __dir__)

# Karafka app object
class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = {
      'bootstrap.servers': 'pkc-lzvrd.us-west4.gcp.confluent.cloud:9092',
      'security.protocol': 'sasl_ssl',
      'sasl.mechanism': 'PLAIN',
      'sasl.username': 'E3OUITFRUK36BCQY',
      'sasl.password': 'wdWQBT64uJB/06VepuBn2Q/3qP0tPAkivdwIe4+N5/Fy3bI1odULBk3g8k4o/5rF',
    }
    config.client_id = 'example_app'
    config.concurrency = 2
    config.max_wait_time = 500 # 0.5 second
    # Recreate consumers with each batch. This will allow Rails code reload to work in the
    # development mode. Otherwise Karafka process would not be aware of code changes
    config.consumer_persistence = !Rails.env.development?
  end

  KafkaRailsIntegration.configure_with()
  #
  # === Confluent Cloud API key: lkc-k8jz3g ===
  #
  #   API key:
  #   E3OUITFRUK36BCQY
  #
  # API secret:
  #   wdWQBT64uJB/06VepuBn2Q/3qP0tPAkivdwIe4+N5/Fy3bI1odULBk3g8k4o/5rF
  #
  # Bootstrap server:
  #   pkc-lzvrd.us-west4.gcp.confluent.cloud:9092
  #
  #
  # # Required connection configs for Kafka producer, consumer, and admin
  # bootstrap.servers=pkc-lzvrd.us-west4.gcp.confluent.cloud:9092
  # security.protocol=SASL_SSL
  # sasl.mechanisms=PLAIN
  # sasl.username=E3OUITFRUK36BCQY
  # sasl.password=wdWQBT64uJB/06VepuBn2Q/3qP0tPAkivdwIe4+N5/Fy3bI1odULBk3g8k4o/5rF
  #
  # # Best practice for higher availability in librdkafka clients prior to 1.7
  # session.timeout.ms=45000
  #
  #
  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate, if you want to achieve max performance,
  # listen to only what you really need for given environment.
  # Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  # # Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)
  # Karafka.producer.monitor.subscribe(
  #   WaterDrop::Instrumentation::LoggerListener.new(Karafka.logger)
  # )
  #
  # routes.draw do
  #   # This needs to match queues defined in your ActiveJobs
  #   active_job_topic :default
  #
  #   topic :visits do
  #     consumer VisitsConsumer
  #   end
  # end
end
