require 'act_like/checks/check'
require 'act_like/checks/result'

module ActLike
  module Checks
    class RequiredKeywordArguments < Check
      def compare
        if left_set == right_set
          Result.new(true)
        else
          Result.new(false, left: left_set, right: right_set)
        end
      end

      private

      def left_set
        @left_set ||= required(left)
      end

      def right_set
        @right_set ||= required(right)
      end

      def required(method)
        method
          .parameters
          .select { |(type,_)| type == :keyreq }
          .map(&:last)
          .sort
      end
    end
  end
end
