require 'act_like/checks/check'
require 'act_like/checks/result'

module ActLike
  module Checks
    class OptionalKeywordArguments < Check
      def compare
        if right_set.count >= left_set.count
          Result.new(true)
        else
          Result.new(false, left: left_set, right: right_set)
        end
      end

      private

      def left_set
        @left_set ||= optional(left)
      end

      def right_set
        @right_set ||= optional(right)
      end

      def optional(method)
        method
          .parameters
          .select { |(type,_)| type == :key }
          .map(&:last)
          .sort
      end
    end
  end
end
