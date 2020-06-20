# frozen_string_literal: true

require 'sourcescrub/version'

require 'sourcescrub/account'
require 'sourcescrub/client'
require 'sourcescrub/models'

module Sourcescrub
  TOKEN_URL = 'https://identity.sourcescrub.com'
  TOKEN_URI = '/connect/token'

  # API URL
  API_URI   = 'https://api.sourcescrub.com/'

  class Error < StandardError; end
  # Your code goes here...
end
