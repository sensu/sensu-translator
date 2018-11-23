module Sensu
  module Translator
    module Translations
      def go_spec(type, object, namespace)
        {
          :type => type.to_s.capitalize,
          :spec => object.merge(:namespace => namespace)
        }
      end

      def translate_check(check, namespace)
        check[:subscriptions] = check.delete(:subscribers) || []
        if check[:standalone]
          check.delete(:standalone)
          check[:subscriptions] << "standalone"
        end
        check[:publish] = check.fetch(:publish, true)
        check[:handlers] ||= [check.fetch(:handler, "default")]
        if check[:source]
          check[:proxy_entity_id] = check.delete(:source)
        end
        go_spec(:check, check, namespace)
      end

      def translate_filter(filter, namespace)
        puts "Sensu 1.x filter translation is not yet supported"
        puts "Unable to translate Sensu 1.x filter: #{filter}"
        nil
      end

      def translate_mutator(mutator, namespace)
        go_spec(:mutator, mutator, namespace)
      end

      def translate_handler(handler, namespace)
        go_spec(:handler, handler, namespace)
      end

      def translate_extension(extension, namespace)
        puts "Sensu 1.x extension translation is not yet supported"
        puts "Unable to translate Sensu 1.x extension: #{extension}"
        nil
      end
    end
  end
end
