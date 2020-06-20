# frozen_string_literal: true

# Root Sourcescrub
module Sourcescrub
  # Models
  module Models
    # Company
    class Company < Entity
      ENDPOINT = 'companies'

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
          currentEmployeeRange
          currentJobOpenings
          investors
          personalTags
          firmTags
        ]
      end
    end
  end
end
