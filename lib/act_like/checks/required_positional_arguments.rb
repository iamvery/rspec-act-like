require 'act_like/checks/result'

module ActLike
  module Checks
    class RequiredPositionalArguments
      def initialize(left, rigth)
        @left = left
        @right = rigth
      end

      def compare
        if left_count == right_count
          Result.new(true)
        else
          Result.new(false, left: left_count, right: right_count)
        end
      end

      private

      attr_reader :left, :right

      def left_count
        @left_count ||= required(left).count
      end

      def right_count
        @right_count ||= required(right).count
      end

      def required(method)
        method.parameters.select { |(type,_)| type == :req }
      end
    end
  end
end
