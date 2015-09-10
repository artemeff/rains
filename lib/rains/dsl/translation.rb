module Rains
  module DSL
    module Translation
      def translate
        I18n.translate(translation_key)
      end

      def translation_key
        "#{translation_root}.#{translation_class}"
      end

      def translation_class
        Inflecto.underscore(self.class).gsub(/\//, '.')
      end

      def translation_root
        :rains
      end
    end
  end
end
