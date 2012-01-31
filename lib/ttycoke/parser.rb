# -*- encoding: utf-8 -*-
module TTYCoke
  class Parser
    extend TTYCoke::Log

    class << self
      def coke! prgm, line
        program = raw_config_parser(prgm, line)
        if program[:exist]
          parse(program[:match])
        else
          return line
        end
      end

      private

      def raw_config_parser prgm, line, program={}
        if prgm.is_a?(Hash)
          program.merge!(raw_config_to_hash(prgm, line))
        elsif prgm.is_a?(Array)
          prgm[0].each { |p| program.merge!(raw_config_to_hash(p[1], line)) }
        else
          program.merge!(exist: false)
        end
        program
      end

      def raw_config_to_hash prgm, line, program={}
        if mch = prgm.fetch('regex').match(line)
          program.merge!({
              exist: true,
              match: mch
            })
        end
        program
      end

      def matchd_color mtch, current_match, color=''
        mtch.names.each { |name|
          color = name if mtch[name].to_s == current_match.to_s
        }
        color
      end

      def parse mtch, coked_str=''
        (mtch.size - 1).times do |i|
          color = matchd_color(mtch, mtch[i+1].to_s)
          if color.empty? # ANSI fking bug!
            coked_str << mtch[i+1]
          else
            coked_str << mtch[i+1].send(color.to_sym)
          end
        end
        coked_str
      end
    end
  end
end
