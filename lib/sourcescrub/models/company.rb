# frozen_string_literal: true

# Root Sourcescrub
module Sourcescrub
  # Models
  module Models
    # Company
    class Company < Entity
      ENDPOINT = 'companies'

      # rubocop:disable Metrics/MethodLength
      def field_ids
        %w[
          id
          companyType
          name
          informalName
          website
          domain
          description
          foundingYear
          location
          city
          state
          postalCode
          country
          parentCompanyDomain
          phoneNumber
          specialties
          facebook
          twitter
          crunchbase
          linkedIn
          totalAmountInvested
          currentEmployeeCount
          threeMonthsGrowthRate
          sixMonthsGrowthRate
          nineMonthsGrowthRate
          twelveMonthsGrowthRate
          currentEmployeeRange
          currentJobOpenings
          growthIntent
          investors
          personalTags
          firmTags
          customScore
          industries
          modifiedDate
          endMarkets
          productsAndServices
        ]
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
