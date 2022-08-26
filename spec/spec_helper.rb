require_relative '../src/handler'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
 
  config.disable_monkey_patching!
 
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  ENV['RANDOM_CHANNEL_ID']='123456'
  ENV['SLACKBOT_SERVICE_URL']='url'
  ENV['SLACKBOT_SERVICE_API_KEY']='api-key'
end
