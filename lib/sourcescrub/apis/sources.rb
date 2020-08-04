# frozen_string_literal: true

require_relative './../utils/ss_model'

# Root Sourcescrub
module Sourcescrub
  # Apis
  module Apis
    # Companies endpoint
    class Sources
      include ::Sourcescrub::Utils::SsModel

      attr_accessor :args

      def initialize(source_id, args)
        @source_id  = source_id
        @model_type = args.delete(:model_type)
        @args       = args
      end

      def request_url
        [
          Models::Source::ENDPOINT,
          @source_id
        ].compact.join('/')
      end

      def companies_url
        [
          Models::Source::ENDPOINT,
          @source_id,
          'companies'
        ].compact.join('/')
      end
    end
  end
end
