# frozen_string_literal: true

module Sourcescrub
  # Utilities
  module Utils
    # All Searches Parameters
    module SearchParams
      module_function

      def source_params(args = {})
        recursive_compact(build_args(args))
      end

      private

      def build_args(args)
        {
          'filters' => {
            'startDateRange' => {
              'from' => args.dig(:start_date, :from),
              'to' => args.dig(:start_date, :to)
            },
            'endDateRange' => {
              'from' => args.dig(:end_date, :from),
              'to' => args.dig(:end_date, :to)
            },
            'modifiedDateRange' => {
              'from' => args.dig(:modified, :from),
              'to' => args.dig(:modified, :to)
            },
            'completedAtDateRange' => {
              'from' => args.dig(:completed_date, :from),
              'to' => args.dig(:completed_date, :to)
            },
            'industries' => args.dig(:industries),
            'statuses' => args.dig(:statuses),
            'sourceTypes' => args.dig(:source_types),
            'clientStatuses' => args.dig(:client_statuses),
            'completedAt' => args.dig(:completed_at)
          },
          'searchText' => args.dig(:search_text),
          'limit' => args.dig(:limit) || 100,
          'offset' => args.dig(:offset) || 0,
          'orderBy' => args.dig(:order_by) || 'endDate DESC'
        }
      end

      def recursive_compact(hash_or_array)
        block = proc do |*args|
          v = args.last
          v.delete_if(&block) if v.respond_to? :delete_if
          v.nil? || v.respond_to?(:"empty?") && v.empty?
        end

        hash_or_array.delete_if(&block)
      end
    end
  end
end
