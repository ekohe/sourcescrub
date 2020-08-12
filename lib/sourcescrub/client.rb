# frozen_string_literal: true

require_relative './utils/request'
require_relative './apis/companies'
require_relative './apis/sources'

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
      api = companies_api(domain, args.merge(model_type: company_card_mappings[args[:card_id]]))

      Models::CompanyItems.new.parse_response_items(
        domain,
        api.kclass_name,
        get(api.request_url, api.args)
      )
    end

    # The max limit range is 0 - 100
    def all_sources(args = { sourceStatus: 'None', limit: 100, offset: 0 })
      api = source_api('sources', args)

      Models::SourceItems.new.parse_response_items(
        api.kclass_name,
        get(api.request_url, api.args)
      )
    end

    def sources(source_id, args = {})
      api = source_api(source_id, args)

      api.sobject.parse_response get(api.request_url, api.args)
    end

    def source_companies(source_id, args = {})
      api = source_companies_api(source_id, args)

      Models::CompanyItems.new.parse_response_items(
        source_id,
        api.kclass_name,
        get(api.companies_url, api.args)
      )
    end

    private

    def companies_api(domain, args)
      @companies_api ||= Apis::Companies.new(
        domain,
        { model_type: 'company' }.merge(args)
      )
    end

    def source_api(source_id, args)
      @source_api ||= Apis::Sources.new(
        source_id,
        { model_type: 'source' }.merge(args)
      )
    end

    def source_companies_api(source_id, args)
      @source_companies_api ||= Apis::Sources.new(
        source_id,
        { model_type: 'company' }.merge(args)
      )
    end

    def company_card_mappings
      {
        'sources' => 'source',
        'people' => 'person',
        'financials' => 'financial',
        'investments' => 'investment',
        'employees' => 'employee',
        'tags' => 'tag',
        'employeerange' => 'employee_range'
      }
    end
  end
end
