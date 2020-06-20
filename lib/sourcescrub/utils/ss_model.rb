# frozen_string_literal: true

module Sourcescrub
  # Utils
  module Utils
    # API Request
    module SsModel
      attr_accessor :model_type

      # module_function

      def sobject
        kclass_name.new
      end

      def kclass_name
        @kclass_name ||= exact_kclass_object
      end

      def exact_kclass_object
        return model_type if model_type.is_a?(Class)

        ss_type = [
          'Sourcescrub',
          'Models',
          model_type.split('_').map(&:capitalize).join
        ].join('::')

        Kernel.const_get("::#{ss_type}")
      end
    end
  end
end
