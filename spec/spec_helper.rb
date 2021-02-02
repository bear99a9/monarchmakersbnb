# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require './spec/units/database_helper'

require 'simplecov'
SimpleCov.start

# require our Sinatra app file
require File.join(File.dirname(__FILE__), '..', 'app.rb')
require 'capybara'
require 'capybara/rspec'
require 'rspec'
# tell Capybara about our app class
Capybara.app = MMBB

RSpec.configure do |config|
  config.before(:each) do
    truncate_test_database
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
