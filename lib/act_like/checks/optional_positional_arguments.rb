require 'act_like/checks/check'
require 'act_like/checks/result'

module ActLike
  module Checks
    class OptionalPositionalArguments < Check
      def compare
        if right_count >= left_count
          Result.new(true)
        else
          Result.new(false, left: left_count, right: right_count)
        end
      end

      private

      def left_count
        @left_count ||= optional(left).count
      end

      def right_count
        @right_count ||= optional(right).count
      end

      def optional(method)
        method.parameters.select { |(type,_)| type == :opt }
      end
    end
  end
end
