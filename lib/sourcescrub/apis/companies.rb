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

      def initialize(domain, args)
        @domain     = domain
        @model_type = args.delete(:model_type)
        @card_id    = args.delete(:card_id)
        @args       = args
      end

      def request_url
        [
          kclass_name::ENDPOINT,
          @domain,
          @card_id
        ].compact.join('/')
      end
    end
  end
end
