require "optparse"

module Sensu
  module Translator
    class CLI
      # Parse CLI arguments using Ruby stdlib `optparse`. This method
      # provides Sensu Translator with process options (eg. config
      # directory), and can provide users with information, such as the
      # Translator version.
      #
      # @param arguments [Array] to parse.
      # @return [Hash] options
      def self.read(arguments=ARGV)
        options = {
          :output_file => "/tmp/sensu_translated.json"
        }
        if File.exist?("/etc/sensu/config.json")
          options[:config_file] = "/etc/sensu/config.json"
        end
        if Dir.exist?("/etc/sensu/conf.d")
          options[:config_dirs] = ["/etc/sensu/conf.d"]
        end
        optparse = OptionParser.new do |opts|
          opts.on("-h", "--help", "Display this message") do
            puts opts
            exit
          end
          opts.on("-V", "--version", "Display version") do
            puts VERSION
            exit
          end
          opts.on("-c", "--config FILE", "Sensu 1.x JSON config FILE. Default: /etc/sensu/config.json (if exists)") do |file|
            options[:config_file] = file
          end
          opts.on("-d", "--config_dir DIR[,DIR]", "DIR or comma-delimited DIR list for Sensu 1.x JSON config files. Default: /etc/sensu/conf.d (if exists)") do |dir|
            options[:config_dirs] = dir.split(",")
          end
          opts.on("-o", "--output_file FILE", "Sensu 2.0 config output file. Default: /tmp/sensu_translated.json") do |file|
            options[:output_file] = file
          end
        end
        optparse.parse!(arguments)
        options
      end
    end
  end
end
