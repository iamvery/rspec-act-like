require 'rspec-act-like'

RSpec.describe 'act_like RSpec matcher' do
  class Duc
    def quack(bar); end
  end

  class Duk
    def quack(baz); end
  end

  class Goos
    def quack; end
  end

  it 'quacks therefore it is' do
    expect(Duc).to act_like(Duk)
    expect(Goos).not_to act_like(Duk)
  end
end
