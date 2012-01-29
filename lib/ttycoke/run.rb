# -*- encoding: utf-8 -*-
module TTYCoke
  class Run
    def initialize argv={}
      log_rescue(self, __method__, caller) {
        @argv     = argv
        @prog     = TTYCoke::Config.new.find_program(@argv.fetch(0))
      }
      start!
    end

    private

    def start!
      if @prog && $stdout.tty?
        coke_it!
      else
        fallback!
      end
    end

    def coke_it!
      trap_signal(%w(HUP INT QUIT)) #TODO: handle CLD
      log_check_child_exit_status {
        IO.popen(single_quote_argv(@argv)) { |process|
          until process.eof?
            puts Parser.coke!(@prog, process.gets)
          end
        }
      }
    end

    def fallback!
      log_check_child_exit_status { exec(single_quote_argv(@argv)) }
    end

    def trap_signal signals
      log_check_child_exit_status {
        signals.each { |signal|
          trap(signal) {
            log_rescue(self, __method__, caller,
                {signals: signals, signal: signal}) {
              puts reset
            }
            log_rescue(self, __method__, caller,
                {signals: signals, signal: signal}) {
              Process.waitpid2(-1, Process::WNOHANG)
            }
          }
        }
      }
    end

    def single_quote_argv argv
      argv.map! { |arg| arg.gsub(/'/, %q('"'"')) }
      "'" << argv.join(%q(' ')) << "'"
    end
  end
end
