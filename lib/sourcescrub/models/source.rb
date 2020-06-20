# frozen_string_literal: true

module Sourcescrub
  # Models
  module Models
    # Source
    class Source < Entity
      ENDPOINT = 'sources'

      def field_ids
        %w[
          id
          officialTitle
          nickname
          sourceType
          city
          state
          country
          startDate
          endDate
          status
          reviewStatus
          companyCount
          companiesCrmCount
          companiesTaggedCount
        ]
      end
    end
  end
end
