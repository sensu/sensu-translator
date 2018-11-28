module Sensu
  module Translator
    module Translations
      def go_spec(type, object, namespace, name, labels={}, annotations={})
        metadata = {
          :namespace => namespace,
          :name => name,
          :labels => labels,
          :annotations => annotations
        }
        {
          :type => type.to_s.capitalize,
          :spec => object.merge(:metadata => metadata)
        }
      end

      def translate_check(check, namespace, name)
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
        go_spec(:check, check, namespace, name)
      end

      def translate_filter(filter, namespace, name)
        puts "Sensu 1.x filter translation is not yet supported"
        puts "Unable to translate Sensu 1.x filter: #{filter}"
        nil
      end

      def translate_mutator(mutator, namespace, name)
        go_spec(:mutator, mutator, namespace, name)
      end

      def translate_handler(handler, namespace, name)
        go_spec(:handler, handler, namespace, name)
      end

      def translate_extension(extension, namespace, name)
        puts "Sensu 1.x extension translation is not yet supported"
        puts "Unable to translate Sensu 1.x extension: #{extension}"
        nil
      end
    end
  end
end
