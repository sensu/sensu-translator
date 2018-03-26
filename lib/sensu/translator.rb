require "sensu/translator/cli"
require "sensu/translator/translations"
require "sensu/translator/version"

require "sensu/json"
require "sensu/settings"

module Sensu
  module Translator
    class Runner
      include Translations

      def initialize
        @options = CLI.read
      end

      def load_v1_settings
        settings = Sensu::Settings.load(@options)
        unless settings.errors.empty?
          puts "Sensu 1.x configuration is invalid!"
          puts Sensu::JSON.dump({:errors => settings.errors}, :pretty => true)
          exit 2
        end
        settings.to_hash
      end

      def translate(v1_settings)
        v2_settings = []
        Sensu::Settings::CATEGORIES.each do |category|
          method_name = "translate_#{category.to_s.chop}"
          v1_settings[category].each do |object|
            v2_settings << send(method_name, object)
          end
        end
        v2_settings
      end

      def create_output_file!(v2_settings)
        content = Sensu::JSON.dump(v2_settings, :pretty => true)
        File.open(@options[:output_file], "w") do |file|
          file.write(content)
        end
      end

      def run
        v1_settings = load_v1_settings
        v2_settings = translate(v1_settings)
        create_output_file!(v2_settings)
      end
    end
  end
end
