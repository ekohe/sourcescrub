# frozen_string_literal: true

module Sourcescrub
  # Models
  module Models
    # Investment
    class Investment < Entity
      ENDPOINT = 'investments'

      def field_ids
        %w[
          amount
          dateOfRaise
          round
          investors
          valuation
        ]
      end
    end
  end
end
