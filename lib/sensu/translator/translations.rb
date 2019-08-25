module Sensu
  module Translator
    module Translations
      def go_spec(type, spec, namespace, name, labels={}, annotations={})
        metadata = {
          :namespace => namespace,
          :name => name,
          :labels => labels,
          :annotations => annotations
        }
        {
          :api_version => "core/v2",
          :type => type.to_s.capitalize,
          :metadata => metadata,
          :spec => spec
        }
      end

      def translate_check(object, namespace, name)
        check = {}
        check[:command] = object.delete(:command)
        if object[:standalone]
          object.delete(:standalone)
          check[:subscriptions] = ["standalone"]
        else
          check[:subscriptions] = object.delete(:subscribers) || []
        end
        publish = object.delete(:publish)
        publish = true if publish.nil?
        check[:publish] = publish
        check[:interval] = object.delete(:interval) if object[:interval]
        check[:cron] = object.delete(:cron) if object[:cron]
        check[:handlers] = object.delete(:handlers) || ["default"]
        check[:handlers] << object.delete(:handler) if object[:handler]
        check[:handlers].uniq!
        check[:proxy_entity_name] = object.delete(:source) if object[:source]
        check[:stdin] = object.delete(:stdin) if object[:stdin]
        check[:timeout] = object.delete(:timeout) if object[:timeout]
        check[:ttl] = object.delete(:ttl) if object[:ttl]
        check[:ttl_status] = object.delete(:ttl_status) if object[:ttl_status]
        check[:low_flap_threshold] = object.delete(:low_flap_threshold) if object[:low_flap_threshold]
        check[:high_flap_threshold] = object.delete(:high_flap_threshold) if object[:high_flap_threshold]
        # TODO: subdue, hooks
        annotations = {}
        unless object.empty?
          annotations["sensu.io.json_attributes".to_sym] = Sensu::JSON.dump(object)
        end
        annotations["fatigue_check/occurrences"] = object[:occurrences].to_s if object[:occurrences]
        annotations["fatigue_check/interval"] = object[:refresh].to_s if object[:refresh]
        go_spec(:check, check, namespace, name, {}, annotations)
      end

      def translate_filter(object, namespace, name)
        puts "Sensu 1.x filter translation is not yet supported"
        puts "Unable to translate Sensu 1.x filter: #{name} #{object}"
        nil
      end

      def translate_mutator(object, namespace, name)
        go_spec(:mutator, object, namespace, name)
      end

      def translate_handler(object, namespace, name)
        go_spec(:handler, object, namespace, name)
      end

      def translate_extension(object, namespace, name)
        puts "Sensu 1.x extension translation is not yet supported"
        puts "Unable to translate Sensu 1.x extension: #{name} - #{object}"
        nil
      end
    end
  end
end
