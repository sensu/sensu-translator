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
        check[:subscriptions] = check.delete(:subscribers)
        check[:publish] = check.fetch(:publish, true)
        check[:handlers] ||= [check.fetch(:handler, "default")]
        v2_spec(:check, check)
      end

      def translate_filter(filter)
        puts "Sensu 1.x filter translation is not yet supported"
        puts "Unable to translate Sensu 1.x filter: #{filter}"
        nil
      end

      def translate_mutator(mutator)
        v2_spec(:mutator, mutator)
      end

      def translate_handler(handler)
        v2_spec(:handler, handler)
      end

      def translate_extension(extension)
        puts "Sensu 1.x extension translation is not yet supported"
        puts "Unable to translate Sensu 1.x extension: #{extension}"
        nil
      end
    end
  end
end
