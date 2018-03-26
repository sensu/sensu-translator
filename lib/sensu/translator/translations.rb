module Sensu
  module Translator
    module Translations
      def translate_check(check)
        check
      end

      def translate_filter(filter)
        filter
      end

      def translate_mutator(mutator)
        mutator
      end

      def translate_handler(handler)
        handler
      end

      def translate_extension(extension)
        extension
      end
    end
  end
end
