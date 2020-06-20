# frozen_string_literal: true

module Sourcescrub
  # Models
  module Models
    # Tag
    class Tag < Entity
      ENDPOINT = 'tags'

      def field_ids
        %w[
          id
          name
          firmScoped
          createdDate
        ]
      end
    end
  end
end
