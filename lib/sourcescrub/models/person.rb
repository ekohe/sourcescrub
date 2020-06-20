# frozen_string_literal: true

module Sourcescrub
  # Models
  module Models
    # Person
    class Person < Entity
      ENDPOINT = 'people'

      def field_ids
        %w[
          personId
          firstName
          firstName
          lastName
          linkedIn
          startDate
          endDate
          email
          emailConfirmed
          title
          role
        ]
      end
    end
  end
end
