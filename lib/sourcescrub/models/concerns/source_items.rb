# frozen_string_literal: true

module Sourcescrub
  # Models
  module Models
    # Tag
    class SourceItems < Entity
      attr_accessor :total, :items, :type

      def parse_response_items(kclass_name, response)
        headers = response.dig('headers')
        headers&.keys&.each do |attr_name|
          self.class.send(:define_method, attr_name.gsub('-', '_').to_sym) do
            headers[attr_name]
          end
        end

        dynamic_define_method(self, 'type', kclass_name)
        dynamic_define_method(self, 'total', response.dig('total') || 0)
        dynamic_define_method(self, 'items', source_items(kclass_name, response.dig('items') || []))
        self
      end

      private

      def source_items(kclass_name, items)
        items.each_with_object([]) do |item, results|
          results << kclass_name.new.parse_response(item)
        end
      end
    end
  end
end
