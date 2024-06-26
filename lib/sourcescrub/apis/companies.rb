# frozen_string_literal: true

require_relative './../utils/ss_model'

# Root Sourcescrub
module Sourcescrub
  # Apis
  module Apis
    # Companies endpoint
    class Companies
      include ::Sourcescrub::Utils::SsModel

      attr_accessor :args

      def initialize(identifier, args)
        @identifier = identifier
        @model_type = args.delete(:model_type)
        @card_id    = args.delete(:card_id)
        @args       = args
      end

      def request_url
        [
          Models::Company::ENDPOINT,
          @identifier,
          @card_id
        ].compact.join('/')
      end

      def search_url
        [
          'search',
          Models::Company::ENDPOINT
        ].compact.join('/')
      end
    end
  end
end
