module Sensu
  module Translator
    module Translations
      def v2_spec(type, object)
        {
          :type => type.to_s.capitalize,
          :spec => object.merge(:organization => "default", :environment => "default")
        }
      end

      def translate_check(check)
        v2_spec(:check, check)
      end

      def translate_filter(filter)
        v2_spec(:filter, filter)
      end

      def translate_mutator(mutator)
        v2_spec(:mutator, mutator)
      end

      def translate_handler(handler)
        v2_spec(:handler, handler)
      end

      def translate_extension(extension)
        v2_spec(:extension, extension)
      end
    end
  end
end
