module Sensu
  module Translator
    module Translations
      def v2_spec(type, object, organization, environment)
        {
          :type => type.to_s.capitalize,
          :spec => object.merge(:organization => organization, :environment => environment)
        }
      end

      def translate_check(check, organization, environment)
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
        v2_spec(:check, check, organization, environment)
      end

      def translate_filter(filter, organization, environment)
        puts "Sensu 1.x filter translation is not yet supported"
        puts "Unable to translate Sensu 1.x filter: #{filter}"
        nil
      end

      def translate_mutator(mutator, organization, environment)
        v2_spec(:mutator, mutator, organization, environment)
      end

      def translate_handler(handler, organization, environment)
        v2_spec(:handler, handler, organization, environment)
      end

      def translate_extension(extension, organization, environment)
        puts "Sensu 1.x extension translation is not yet supported"
        puts "Unable to translate Sensu 1.x extension: #{extension}"
        nil
      end
    end
  end
end
