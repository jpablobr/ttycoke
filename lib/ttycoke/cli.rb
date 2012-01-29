# -*- encoding: utf-8 -*-
require 'optparse'
module TTYCoke
  class CLI
    include TTYCoke::Log

    def parse_options argv
      log_rescue(self, __method__, caller) {
        @opts=nil
        @opts = OptionParser.new do |o|
          o.banner = "Usage: ttycoke [-v] [-h] command [<args>]"
          o.separator ""
          o.on("-h", "--help", "Print this help.") {
            return $stderr.puts(@opts)
          }
          o.on("-v", "--version", "Print version.") {
            return $stderr.puts(TTYCoke::Version::STRING)
          }
          o.on("-d", "--debug", "Enable debug output.") {
            $DEBUG = true
          }
          o.separator ""
        end
        @opts.parse!(argv) rescue return $stderr.puts(@opts)
        if argv.empty?
          $stderr.puts(@opts)
        else
          TTYCoke::Run.new(argv)
        end
      }
    end
  end
end
