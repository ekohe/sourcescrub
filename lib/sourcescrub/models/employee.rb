# frozen_string_literal: true

module Sourcescrub
  # Models
  module Models
    # Employee
    class Employee < Entity
      ENDPOINT = 'employees'

      def field_ids
        %w[
          count
          date
        ]
      end
    end
  end
end
