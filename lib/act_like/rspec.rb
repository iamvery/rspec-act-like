require 'act_like/matcher'

RSpec::Matchers.define :act_like do |expected|
  match do |actual|
    matcher = ActLike::Matcher.new(actual, expected)
    @offenses = matcher.offenses
    @offenses.empty?
  end

  failure_message do |actual|
    <<-MSG
    expected #{actual.inspect} to act like #{expected.inspect}

    #{missing_methods}
    #{bad_arity}
    MSG
    # TODO arity details, kwargs details
  end

  failure_message_when_negated do |actual|
    "expected #{actual.inspect} not to act like #{expected.inspect}"
  end

  private

  def missing_methods
    offenses = @offenses[:missing]
    unless offenses.empty?
      "Missing methods: #{offenses.join(', ')}"
    end
  end

  def bad_arity
    offenses = @offenses[:arity]
    unless offenses.empty?
      "Bad arity: #{offenses.join(', ')}"
    end
  end
end
