# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'bcrypt'
gem 'pg'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'sinatra-flash'
gem 'webrick'

group :test do
  gem 'capybara', require: false
  gem 'puma'
  gem 'rspec', require: false
  gem 'rubocop'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'webdrivers', '~> 4.0', require: false
end
