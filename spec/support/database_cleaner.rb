require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:redis, { connection: :test }].strategy = :truncation

    DatabaseCleaner[:redis].clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner[:redis].start
  end

  config.after(:each) do
    DatabaseCleaner[:redis].clean
  end
end