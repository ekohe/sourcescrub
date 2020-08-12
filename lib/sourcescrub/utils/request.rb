# frozen_string_literal: true

require 'faraday'

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
        response = Faraday.new(
          url: API_URI,
          headers: headers,
          request: {
            timeout: 10,
            open_timeout: 5
          }
        ).get(uri, *args)

        response_body = response.body
        raise Error, response_body unless response.status == 200

        response_body = JSON.parse(response_body)
        # Processing different cases for investments
        if response_body.is_a?(Array)
          response_body = if response_body.empty?
                            {}
                          else
                            {
                              'total' => response_body.size,
                              'items' => response_body
                            }
                          end
        end

        response_body.merge('headers' => response.headers)
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

      def debug_mode?
        Sourcescrub.account.debug || false
      end
    end
  end
end
