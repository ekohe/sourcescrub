# frozen_string_literal: true

require 'bundler/setup'
require 'sourcescrub'
require 'pry'

file = File.join(File.dirname(__FILE__), 'sourcescrub.yml')
if File.exist?(file)
  require 'yaml'
  info = YAML.load_file(file)

  username = info['username']
  password = info['password']
  basic    = info['basic']
  debug    = info['debug']
else
  username = 'username'
  password = 'password'
  basic    = 'basic'
  debug    = false
end

Sourcescrub.account.username = username
Sourcescrub.account.password = password
Sourcescrub.account.basic = basic
Sourcescrub.account.debug = debug

require 'vcr'

VCR.configure do |vcr|
  vcr.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  vcr.hook_into :webmock
  vcr.ignore_localhost = true

  # Removes all private data (Basic Auth, Set-Cookie headers...)
  vcr.before_record do |interaction|
    interaction.response.headers.delete('Set-Cookie')
    interaction.response.body.delete('access_token')
    interaction.request.headers.delete('Authorization')
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
