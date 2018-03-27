require "sensu/translator/cli"
require "sensu/translator/translations"
require "sensu/translator/version"

require "sensu/json"
require "sensu/settings"

require "fileutils"

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
        v2_resources = []
        Sensu::Settings::CATEGORIES.each do |category|
          method_name = "translate_#{category.to_s.chop}"
          v1_settings[category].each do |name, settings|
            object = {:name => name.to_s}.merge(settings)
            v2_resources << send(method_name, object)
          end
        end
        v2_resources.compact
      end

      def create_output_files!(v2_resources)
        output_dir = @options[:output_dir]
        Sensu::Settings::CATEGORIES.each do |category|
          category_dir = File.join(output_dir, category.to_s)
          FileUtils.mkdir_p(category_dir)
        end
        v2_resources.each do |v2_resource|
          category = v2_resource[:type].downcase + "s"
          file_name = v2_resource[:spec][:name] + ".json"
          output_file = File.join(output_dir, category, file_name)
          content = Sensu::JSON.dump(v2_resource, :pretty => true)
          File.open(output_file, "w") do |file|
            file.write(content)
          end
        end
      end

      def run
        v1_settings = load_v1_settings
        v2_resources = translate(v1_settings)
        create_output_files!(v2_resources)
        puts "DONE!"
      end
    end
  end
end
