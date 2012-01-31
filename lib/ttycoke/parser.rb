# -*- encoding: utf-8 -*-
module TTYCoke
  class Parser
    extend TTYCoke::Log

    class << self
      def coke! prgm, line
        program = raw_config_parser(prgm, line)
        if program[:exist]
          parse(program)
        else
          return line
        end
      end

      private

      def raw_config_parser prgm, line
        program = {}
        if prgm.is_a?(Hash) # single regex
          if mch = prgm.fetch('regex').match(line)
            program.merge!({
                exist: true,
                clrs: prgm.fetch('clrs'),
                match: mch
              })
          end
        elsif prgm.is_a?(Array) # multiple regexps
          prgm[0].each { |p|
            if mch = p[1].fetch('regex').match(line)
              program.merge!({
                  exist: true,
                  clrs: p[1].fetch('clrs'),
                  match: mch
                })
            end # TODO: ATM, it only colors the last matched line!
          }
        else
          program.merge!(exist: false)
        end
        program
      end

      def parse prgm, coked_str=''
        (prgm.fetch(:match).size - 1).times do |i|
          coked_str << prgm.fetch(:match)[i+1].send(prgm.fetch(:clrs).fetch(i))
        end
        coked_str
      end
    end
  end
end
