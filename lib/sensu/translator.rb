require "sensu/translator/cli"
require "sensu/translator/deep_merge"
require "sensu/translator/version"

module Sensu
  module Translator
    class Runner
      def initialize
        @options = CLI.read
      end

      def run
        puts @options.inspect
      end
    end
  end
end
