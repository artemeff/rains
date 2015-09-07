module Rains
  class Form
    extend DSL::Assertions
    include Virtus.model(strict: true)

    def as_form
      attributes
    end

    def validate
      cached = as_form
      truthy = ::Assertion::State.new(true)

      __assertions__.inject(truthy) do |acc, assertion|
        acc + assertion[cached]
      end
    end
  end
end
