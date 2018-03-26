require "sensu/translator/cli"
require "sensu/translator/version"

require "sensu/settings"

module Sensu
  module Translator
    class Runner
      def initialize
        @options = CLI.read
      end

      def run
        @settings = Sensu::Settings.load(@options)
        puts @settings.to_hash
      end
    end
  end
end
