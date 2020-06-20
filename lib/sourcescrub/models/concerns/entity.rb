# frozen_string_literal: true

require_relative './../../utils/response'

module Sourcescrub
  # Get the data from API
  module Models
    # Entity
    class Entity
      include ::Sourcescrub::Utils::Response

      def fields
        field_ids.map(&:to_sym)
      end

      def parse_response(response)
        dynamic_attributes(self, field_ids, response)
        self
      end

      def as_json
        fields.each_with_object({}) { |item, hash| hash[item] = send(item) }
      end
    end
  end
end
