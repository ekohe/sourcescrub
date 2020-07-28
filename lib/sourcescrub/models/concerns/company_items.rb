# frozen_string_literal: true

module Sourcescrub
  # Models
  module Models
    # Tag
    class CompanyItems < Entity
      attr_accessor :domain, :total, :items, :type

      def parse_response_items(domain, kclass_name, response)
        headers = response.dig('headers')
        headers&.keys&.each do |attr_name|
          self.class.send(:define_method, attr_name.gsub('-', '_').to_sym) do
            headers[attr_name]
          end
        end

        dynamic_define_method(self, 'domain', domain)
        dynamic_define_method(self, 'type', kclass_name)
        dynamic_define_method(self, 'total', response.dig(total_key) || 0)
        dynamic_define_method(self, 'items', company_items(kclass_name, response.dig(items_key) || []))
        self
      end

      private

      def company_items(kclass_name, items)
        items.each_with_object([]) do |item, results|
          results << kclass_name.new.parse_response(item)
        end
      end

      def total_key
        case type_name
        when 'Person'
          'totalPeople'
        else
          'total'
        end
      end

      def items_key
        case type_name
        when 'Person'
          'peopleAllocations'
        else
          'items'
        end
      end

      def type_name
        type.name.split('::')[-1]
      end
    end
  end
end
