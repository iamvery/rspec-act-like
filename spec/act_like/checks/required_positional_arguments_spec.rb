require 'spec_helper'
require 'act_like/checks/required_positional_arguments'

RSpec.describe ActLike::Checks::RequiredPositionalArguments do
  def one(a); end
  def two(b, c = :default); end
  def three(d, e); end

  it 'matches when methods have the same required, positional arguments' do
    m1 = method(:one)
    m2 = method(:two)

    result = described_class.new(m1, m2).compare

    expect(result.match).to be(true)
  end

  it 'does not match and reports difference in required, positional arguments' do
    m1 = method(:one)
    m3 = method(:three)

    result = described_class.new(m1, m3).compare

    expect(result.match).to be(false)
    expect(result.difference).to eq(left: 1, right: 2)
  end
end
