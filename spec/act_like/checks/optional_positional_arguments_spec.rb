require 'spec_helper'
require 'act_like/checks/optional_positional_arguments'

RSpec.describe ActLike::Checks::OptionalPositionalArguments do
  def one(a, b = :default); end
  def two(c, d = :default, e = :default); end

  it 'matches when right has >= the number of optional, positional arguments' do
    m1 = method(:one)
    m2 = method(:two)

    result = described_class.new(m1, m2).compare

    expect(result.match).to be(true)
  end

  it 'does not match and reports difference in optional, positional arguments' do
    m1 = method(:one)
    m2 = method(:two)

    result = described_class.new(m2, m1).compare

    expect(result.match).to be(false)
    expect(result.difference).to eq(left: 2, right: 1)
  end
end
