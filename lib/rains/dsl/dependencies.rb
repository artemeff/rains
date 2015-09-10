module Rains
  module DSL
    module Dependencies
      def depends_on(name, klass)
        if Helpers.kind_of_service_class?(klass)
          define_method(name) { klass }
        else
          raise TypeError, "The #{klass} is not a Rains::Service"
        end
      end
    end
  end
end
