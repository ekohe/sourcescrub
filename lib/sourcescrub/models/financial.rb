# frozen_string_literal: true

module Sourcescrub
  # Models
  module Models
    # Financial
    class Financial < Entity
      ENDPOINT = 'financials'

      def field_ids
        %w[
          year
          revenue
          growth
          growthTimePeriod
        ]
      end
    end
  end
end
