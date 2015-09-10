module Rains
  module Helpers
    module_function

    def kind_of_service_class?(obj)
      obj.is_a?(Class) &&
        obj.ancestors.include?(Service)
    end
  end
end
