require 'database_cleaner'

RSpec.configure do |config|
  
  config.before(:suite) do
    clean_database
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do |example|
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

end

def clean_database
  DatabaseCleaner.clean_with(:truncation, except: %w(ar_internal_metadata))
end
