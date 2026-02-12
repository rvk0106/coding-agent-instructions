# Feature Implementation Conventions
> Tags: conventions, testing, patterns, specs
> Scope: Patterns to follow when implementing any feature in the gem
> Last updated: [TICKET-ID or date]

## Module Structure
```ruby
# lib/gem_name/feature_name.rb
# frozen_string_literal: true

module GemName
  module FeatureName
    # Module-level methods or class definitions
  end
end
```

## Configuration Pattern
```ruby
# If the feature adds config options:
module GemName
  class Configuration
    attr_accessor :feature_option

    def initialize
      @feature_option = "default_value"
    end
  end
end
```

## YARD Documentation
```ruby
# Every public method must have:
# @param, @return, @raise, @example

# @param input [String] the input to process
# @param options [Hash] optional configuration
# @return [GemName::Result] the processed result
# @raise [GemName::ArgumentError] if input is nil
# @example
#   result = GemName.process("hello")
#   result.success? #=> true
def process(input, **options)
  # ...
end
```

## Test Data
```ruby
# Use let/let! for test setup
# Prefer factories or simple object construction

# Simple objects
let(:config) { GemName::Configuration.new }
let(:client) { GemName::Client.new(config: config) }

# With custom values
let(:config) do
  GemName.configure do |c|
    c.api_key = "test_key"
    c.timeout = 5
  end
  GemName.configuration
end
```

## Unit Spec Pattern
```ruby
# spec/gem_name/feature_name_spec.rb
# frozen_string_literal: true

RSpec.describe GemName::FeatureName do
  subject(:feature) { described_class.new(**params) }

  let(:params) { { key: "value" } }

  describe "#public_method" do
    context "with valid input" do
      it "returns expected result" do
        result = feature.public_method("input")
        expect(result).to be_a(GemName::Result)
        expect(result.success?).to be true
      end
    end

    context "with invalid input" do
      it "raises ArgumentError" do
        expect { feature.public_method(nil) }
          .to raise_error(GemName::ArgumentError, /must not be nil/)
      end
    end

    context "with edge case" do
      it "handles empty string" do
        result = feature.public_method("")
        expect(result.data).to be_empty
      end
    end
  end
end
```

## Integration Spec Pattern
```ruby
# spec/integration/feature_name_spec.rb (if needed)
# frozen_string_literal: true

RSpec.describe "FeatureName integration", type: :integration do
  before do
    GemName.configure do |c|
      c.api_key = ENV.fetch("TEST_API_KEY", "test_key")
    end
  end

  after do
    GemName.reset_configuration!
  end

  it "processes end-to-end" do
    result = GemName.process("real input")
    expect(result.success?).to be true
  end
end
```

## Shared Examples
```ruby
# spec/support/shared_examples/
RSpec.shared_examples "a validatable input" do |method_name|
  it "raises on nil input" do
    expect { subject.public_send(method_name, nil) }
      .to raise_error(GemName::ArgumentError)
  end

  it "raises on empty string" do
    expect { subject.public_send(method_name, "") }
      .to raise_error(GemName::ArgumentError)
  end
end
```

## Changelog
<!-- Update when conventions change -->
