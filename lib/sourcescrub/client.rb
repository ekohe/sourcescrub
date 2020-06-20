# frozen_string_literal: true

require_relative './utils/request'
require_relative './apis/companies'

# Root Sourcescrub
module Sourcescrub
  # Client
  class Client
    include Utils::Request

    def headers
      @token || authenticate

      { 'Authorization' => "Bearer #{@token}" }
    end

    def companies(domain, args = {})
      api = companies_api(domain, args)

      api.sobject.parse_response get(api.request_url, api.args)
    end

    private

    def companies_api(domain, args)
      @companies_api || Apis::Companies.new(domain, args.merge(model_type: 'company'))
    end
  end
end
