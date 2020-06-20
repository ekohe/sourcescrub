# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
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
        response = Faraday.new(url: API_URI) do |faraday|
          faraday.headers = headers
          faraday.request   :json
          faraday.response  :json
          faraday.response  :logger, ::Logger.new(STDOUT), bodies: true if debug_mode?
        end.get(uri, *args)

        return response.body if response.status == 200

        raise Error, response.body
      end

      def put(uri, args)
        response = Faraday.new(url: API_URI) do |faraday|
          faraday.headers = headers
          faraday.request   :json
          faraday.response  :json
          faraday.response :logger, ::Logger.new(STDOUT), bodies: true if debug_mode?
        end.put(uri, args)

        return response.body if response.status == 200

        raise Error, response.body
      end

      def delete(uri, args)
        response = Faraday.new(url: API_URI) do |faraday|
          faraday.headers = headers
          faraday.request   :json
          faraday.response  :json
          faraday.response :logger, ::Logger.new(STDOUT), bodies: true if debug_mode?
        end.delete(uri, args)

        return response.body if response.status == 200

        raise Error, response.body
      end

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

        response = Faraday.new(url: TOKEN_URL) do |faraday|
          faraday.headers = {
            'Content-Type' => 'application/x-www-form-urlencoded',
            'Authorization' => Sourcescrub.account.basic
          }
          faraday.adapter   Faraday.default_adapter
          faraday.request   :json
          faraday.response  :json
          faraday.response :logger, ::Logger.new(STDOUT), bodies: true if debug_mode?
        end.post(TOKEN_URI, body)

        raise 'Apptopia error: Service Unavailable' unless response.status == 200

        @token = response.body['access_token']
      end

      private

      def debug_mode?
        Sourcescrub.account.debug || false
      end
    end
  end
end
