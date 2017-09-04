require 'act_like/matcher'

RSpec.describe ActLike::Matcher do
  describe 'public methods' do
    it 'matches when both define the same public class methods' do
      duc = Class.new do
        def self.quack; end
      end

      duk = Class.new do
        def self.quack; end
      end

      goos = Class.new

      good_matcher = described_class.new(duk, duc)
      bad_matcher = described_class.new(goos, duc)
      good_matcher.check
      bad_matcher.check

      expect(good_matcher.offenses).to be_empty
      expect(bad_matcher.offenses).to eq({ missing: ['self.quack'] })
    end

    it 'matches when both define the same public instance methods' do
      duc = Class.new do
        def quack; end
      end

      duk = Class.new do
        def quack; end
      end

      goos = Class.new

      good_matcher = described_class.new(duk, duc)
      bad_matcher = described_class.new(goos, duc)
      good_matcher.check
      bad_matcher.check

      expect(good_matcher.offenses).to be_empty
      expect(bad_matcher.offenses).to eq({ missing: ['quack'] })
    end

    it 'matches when expected type defines additional public class methods' do
      duc = Class.new do
        def self.quack; end
      end

      duk = Class.new do
        def self.quack; end
        def self.waddle; end
      end

      matcher = described_class.new(duk, duc)
      matcher.check

      expect(matcher.offenses).to be_empty
    end

    it 'matches when expected type defines additional public instance methods' do
      duc = Class.new do
        def quack; end
      end

      duk = Class.new do
        def quack; end
        def waddle; end
      end

      matcher = described_class.new(duk, duc)
      matcher.check

      expect(matcher.offenses).to be_empty
    end
  end

  describe 'positional arguments' do
    it 'matches when public class method airty is the same' do
      duc = Class.new do
        def self.quack(tone); end
      end

      duk = Class.new do
        def self.quack(sound); end
      end

      goos = Class.new do
        def self.quack; end
      end

      good_matcher = described_class.new(duk, duc)
      bad_matcher = described_class.new(goos, duc)
      good_matcher.check
      bad_matcher.check

      expect(good_matcher.offenses).to be_empty
      expect(bad_matcher.offenses).to eq({ arity: ['self.quack'] })
    end

    it 'matches when public instance method airty is the same' do
      duc = Class.new do
        def quack(tone); end
      end

      duk = Class.new do
        def quack(sound); end
      end

      goos = Class.new do
        def quack; end
      end

      good_matcher = described_class.new(duk, duc)
      bad_matcher = described_class.new(goos, duc)
      good_matcher.check
      bad_matcher.check

      expect(good_matcher.offenses).to be_empty
      expect(bad_matcher.offenses).to eq({ arity: ['quack'] })
    end
  end

  describe 'keyword arguments' do
    it 'matches when public class methods have the same required keyword arguments'
  end
end
