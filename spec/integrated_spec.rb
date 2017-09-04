require 'rspec-act-like'

RSpec.describe 'act_like RSpec matcher' do
  class RealDuck
    def quack(bar); end
  end

  class FakeDuck
    def quack(baz); end
  end

  class Goose
    def quack; end
  end

  it 'quacks therefore it is' do
    expect(FakeDuck).to act_like(RealDuck)
    expect(Goose).not_to act_like(RealDuck)
  end
end
