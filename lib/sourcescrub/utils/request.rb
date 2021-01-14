# frozen_string_literal: true

require 'faraday'
require 'logger'

module Sourcescrub
  # Utils
  module Utils
    # Key Reminder
    module Request
      module_function

      # SourceScrub API Response Headers
      #
      #   X-RateLimit-Limit - Allowed number of requests for User Firm per month
      #   X-RateLimit-Remaining - Number of requests remaining for User Firm in current month
      #   X-RateLimit-Reset - Time until the request counter resets (1st of the month 00:00 UTC)

      #   Limit of requests per second: 30
      #
      #
      def get(uri, *args)
        response = Faraday.new(request_options(args)) do |faraday|
          faraday.headers['Content-Type'] = 'application/json-patch+json'
          faraday.adapter Faraday.default_adapter
          faraday.response :logger, ::Logger.new(STDOUT), bodies: true if debug_mode?
        end.get(uri)

        raise Error, response.body unless response.status == 200

        parse_api_response(response.body).merge('headers' => response.headers)
      end

      # Search endpoints
      def search(uri, args)
        response = Faraday.new(request_options(args)) do |faraday|
          faraday.headers['Content-Type'] = 'application/json-patch+json'
          faraday.adapter Faraday.default_adapter
          faraday.response :logger, ::Logger.new(STDOUT), bodies: true if debug_mode?
        end.post(uri, args.to_json)

        raise Error, response.body unless response.status == 200

        parse_api_response(response.body).merge('headers' => response.headers)
      end

      # def put(uri, args)
      #   response = Faraday.new(url: API_URI) do |faraday|
      #     faraday.headers = headers
      #     faraday.request   :json
      #     faraday.response  :json
      #     faraday.response :logger, ::Logger.new(STDOUT), bodies: true if debug_mode?
      #   end.put(uri, args)

      #   return response.body if response.status == 200

      #   raise Error, response.body
      # end

      # def delete(uri, args)
      #   response = Faraday.new(url: API_URI) do |faraday|
      #     faraday.headers = headers
      #     faraday.request   :json
      #     faraday.response  :json
      #     faraday.response :logger, ::Logger.new(STDOUT), bodies: true if debug_mode?
      #   end.delete(uri, args)

      #   return response.body if response.status == 200

      #   raise Error, response.body
      # end

      # Authentication Token
      #
      #   In order to obtain the authentication token that will be later used to request SourceScrub API:
      #     A POST request has to be made with following configuration:

      #   POST https://identity.sourcescrub.com/connect/token
      #   Content-Type: application/x-www-form-urlencoded
      #   Authorization: Basic xxxxxxxxxxxxxxxxxxxxxxxxxxx

      #   Body:
      #     grant_type=password&username={username}&password={password}&scope=client_api
      def authenticate
        body = "grant_type=password&username=#{Sourcescrub.account.username}&password=#{Sourcescrub.account.password}&scope=client_api"

        response = Faraday.new(
          url: TOKEN_URL,
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded',
            'Authorization' => Sourcescrub.account.basic
          }
        ).post(TOKEN_URI, body)

        raise 'Sourcescrub error: Service Unavailable' unless response.status == 200

        @token = JSON.parse(response.body)['access_token']
      end

      private

      def request_options(args)
        {
          url: API_URI,
          headers: headers,
          request: {
            timeout: 10,
            open_timeout: 5
          },
          params: args[0] || {}
        }
      end

      def parse_api_response(response_body)
        response_body = JSON.parse(response_body)

        # Processing different cases for investments
        return response_body unless response_body.is_a?(Array)
        return {} if response_body.empty?

        {
          'total' => response_body.size,
          'items' => response_body
        }
      end

      def debug_mode?
        Sourcescrub.account.debug || false
      end
    end
  end
end
