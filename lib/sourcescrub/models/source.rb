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
          listWebsite
          city
          state
          country
          postalCode
          startDate
          endDate
          status
          reviewStatus
          companyCount
          companiesCrmCount
          companiesTaggedCount
          boothNumber
          affiliation
          rank
          modifiedDate
        ]
      end
    end
  end
end
