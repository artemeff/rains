module Rains
  class Serializer
    include Virtus.value_object

    def as_json
      attributes
    end

    def to_json(*)
      as_json.to_json
    end
  end
end
