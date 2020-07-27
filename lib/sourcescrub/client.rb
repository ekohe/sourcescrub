# frozen_string_literal: true

require_relative './utils/request'
require_relative './apis/companies'

# Root Sourcescrub
module Sourcescrub
  # Client
  class Client
    include Utils::Request

    attr_accessor :token

    def headers
      authenticate if @token.nil?

      { 'Authorization' => "Bearer #{@token}" }
    end

    def company(domain, args = {})
      api = companies_api(domain, args)

      api.sobject.parse_response get(api.request_url, api.args)
    end

    def company_cards(domain, args = {})
      api = companies_api(domain, args.merge(model_type: card_mappings[args[:card_id]]))

      Models::CompanyItems.new.parse_response_items(domain, api.kclass_name, get(api.request_url, api.args))
    end

    private

    def companies_api(domain, args)
      @companies_api || Apis::Companies.new(domain,
                                            { model_type: 'company' }.merge(args))
    end

    def card_mappings
      {
        'sources' => 'source',
        'people' => 'person',
        'financials' => 'financial',
        'investments' => 'investment',
        'employees' => 'employee',
        'tags' => 'tag'
      }
    end
  end
end
