# frozen_string_literal: true

module Sourcescrub
  # Utilities
  module Utils
    # Parse the response. build with object
    module Response
      module_function

      def dynamic_attributes(object, attribute_names, response)
        # Retrieve request limit data from header
        #
        #   .date
        #   .content_type
        #   .server
        #   .content_length
        #   .request_context
        #   .strict_transport_security
        #   .x_ratelimit_limit
        #   .x_ratelimit_remaining
        #   .x_ratelimit_reset
        headers = response.dig('headers')
        headers&.keys&.each do |attr_name|
          object.class.send(:define_method, attr_name.gsub('-', '_').to_sym) do
            headers[attr_name]
          end
        end

        # Setup attributes
        attribute_names.each do |attr_name|
          attr_value = response.dig(attr_name)

          dynamic_define_method(object, attr_name, attr_value)
        end

        object
      end

      private

      def dynamic_define_method(object, attr_name, attr_value)
        # Manually creates methods for both getter and setter and then
        #   sends a message to the new setter with the attr_value
        object.class.send(:define_method, "#{attr_name}=".to_sym) do |value|
          instance_variable_set('@' + attr_name, value)
        end

        object.class.send(:define_method, attr_name.to_sym) do
          instance_variable_get('@' + attr_name.to_s)
        end

        object.send("#{attr_name}=".to_sym, attr_value)
      end
    end
  end
end
