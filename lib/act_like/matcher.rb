module ActLike
  class Matcher
    attr_reader :offenses

    def initialize(actual, expected)
      @actual = actual
      @expected = expected
      @offenses = Hash.new { |offenses, offense| offenses[offense] = Array.new }
    end

    def check
      check_class_methods
      check_instance_methods
    end

    private

    attr_reader :actual, :expected

    def check_instance_methods
      actual
        .public_instance_methods
        .map(&actual.method(:public_instance_method))
        .each_with_object(offenses) { |method, offenses|
        begin
          unless expected.public_instance_method(method.name).arity == method.arity
            offenses[:arity] << method.name.to_s
          end
        rescue NameError
          offenses[:missing] << method.name.to_s
        end
      }
    end

    def check_class_methods
      actual
        .public_methods
        .map(&actual.method(:public_method))
        .each_with_object(offenses) { |method, offenses|
        begin
          unless expected.public_method(method.name).arity == method.arity
            offenses[:arity] << "self.#{method.name}"
          end
        rescue NameError
          offenses[:missing] << "self.#{method.name}"
        end
      }
    end
  end
end
