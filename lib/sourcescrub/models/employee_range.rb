# frozen_string_literal: true

module Sourcescrub
  # Models
  module Models
    # Employee
    class EmployeeRange < Entity
      ENDPOINT = 'employeerange'

      def field_ids
        %w[
          employeeRange
          date
        ]
      end
    end
  end
end
