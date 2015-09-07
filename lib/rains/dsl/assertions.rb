module Rains
  module DSL
    module Assertions
      def self.extended(klass)
        klass.__send__(:define_method, :__assertions__) { [] }
      end

      def assertions(*assertions_list)
        define_method(:__assertions__) { assertions_list }
      end
    end
  end
end
