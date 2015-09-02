module Rains
  module DSL
    module Assertions
      def self.extended(klass)
        klass.send(:define_method, :assertions) { [] }
      end

      def assertions(*assertions_list)
        define_method(:assertions) { assertions_list }
      end
    end
  end
end
