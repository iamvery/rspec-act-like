require 'spec_helper'
require 'act_like/checks/optional_keyword_arguments'

RSpec.describe ActLike::Checks::OptionalKeywordArguments do
  def one(foo:, bar: :default); end
  def two(foo:, bar: :default, baz: :default); end

  it 'matches when right has >= the number of optional, keyword arguments' do
    m1 = method(:one)
    m2 = method(:two)

    result = described_class.new(m1, m2).compare

    expect(result.match).to be(true)
  end

  it 'does not match and reports difference in optional, keyword arguments' do
    m1 = method(:one)
    m2 = method(:two)

    result = described_class.new(m2, m1).compare

    expect(result.match).to be(false)
    expect(result.difference).to eq(left: [:bar, :baz], right: [:bar])
  end
end
