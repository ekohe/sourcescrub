# frozen_string_literal: true

require_relative './utils/request'
require_relative './apis/companies'
require_relative './apis/sources'
require_relative './utils/search_params'

# Root Sourcescrub
module Sourcescrub
  # Client
  class Client
    include Utils::Request
    include Utils::SearchParams

    attr_accessor :token

    def headers
      authenticate if @token.nil?

      { 'Authorization' => "Bearer #{@token}" }
    end

    def companies(args = { limit: 100, offset: 0 })
      api = companies_api(args)

      Models::CompanyItems.new.parse_response_items(
        nil,
        api.kclass_name,
        get(api.search_url, api.args)
      )
    end

    def company(identifier, args = {})
      api = company_api(identifier, args)

      api.sobject.parse_response get(api.request_url, api.args)
    end

    def company_cards(identifier, args = {})
      api = company_api(identifier, args.merge(model_type: company_card_mappings[args[:card_id]]))

      Models::CompanyItems.new.parse_response_items(
        identifier,
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

    def source_search(args = {})
      api = source_search_api(source_params(args))

      Models::SourceItems.new.parse_response_items(
        api.kclass_name,
        search(api.search_url, api.args)
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

    def companies_api(args)
      Apis::Companies.new(
        nil,
        { model_type: 'company' }.merge(args)
      )
    end

    def company_api(identifier, args)
      Apis::Companies.new(
        identifier,
        { model_type: 'company' }.merge(args)
      )
    end

    def source_api(source_id, args)
      Apis::Sources.new(
        source_id,
        { model_type: 'source' }.merge(args)
      )
    end

    def source_search_api(args)
      Apis::Sources.new(
        nil,
        { model_type: 'source' }.merge(args)
      )
    end

    def source_companies_api(source_id, args)
      Apis::Sources.new(
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
