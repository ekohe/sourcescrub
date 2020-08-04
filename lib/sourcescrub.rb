# frozen_string_literal: true

require 'json'
require 'sourcescrub/version'

require 'sourcescrub/account'
require 'sourcescrub/client'
require 'sourcescrub/models'
require 'sourcescrub/utils/veriables'

# Sourcescrub
module Sourcescrub
  TOKEN_URL = 'https://identity.sourcescrub.com'
  TOKEN_URI = '/connect/token'

  # API URL
  API_URI   = 'https://api.sourcescrub.com/'

  class Error < StandardError; end

  include Utils::Veriables
end
