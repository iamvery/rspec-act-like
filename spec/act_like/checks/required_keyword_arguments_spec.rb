require 'spec_helper'
require 'act_like/checks/required_keyword_arguments'

RSpec.describe ActLike::Checks::RequiredKeywordArguments do
  def one(foo:, bar:, baz: :default); end
  def two(bar:, baz: :default, foo:); end
  def three(foo:, qux:); end

  it 'matches when methods have the same required, keyword arguments' do
    m1 = method(:one)
    m2 = method(:two)

    result = described_class.new(m1, m2).compare

    expect(result.match).to be(true)
  end

  it 'does not match and reports difference in required, keyword arguments' do
    m1 = method(:one)
    m3 = method(:three)

    result = described_class.new(m1, m3).compare

    expect(result.match).to be(false)
    expect(result.difference).to eq(left: [:bar, :foo], right: [:foo, :qux])
  end
end
