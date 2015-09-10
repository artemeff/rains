module Rains
  class Service
    include Virtus.model(strict: true)
    extend DSL::Dependencies

    class Error < StandardError
      include DSL::Translation

      def translation_root
        :service
      end
    end

    class Result
      attr_reader :value, :error

      def success?
        false
      end

      def error?
        false
      end

      class Success < Result
        def initialize(value)
          @value = value
        end

        def success?
          true
        end
      end

      class Fail < Result
        def initialize(error)
          @error = error
        end

        def error?
          true
        end
      end
    end

    def action
      raise NotImplementedError
    end

    def call!
      action
    end

    def call
      Result::Success.new(action)
    rescue StandardError => error
      Result::Fail.new(error)
    end
  end
end
