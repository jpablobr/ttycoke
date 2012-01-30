# -*- encoding: utf-8 -*-
module TTYCoke
  class Parser
    extend TTYCoke::Log

    def self.coke! prgm, line
      mtchd, coked_str = prgm.fetch('regex').match(line), ''
      log_rescue(self, __method__, caller, {prgm: prgm, line: line}) {
        if mtchd
          (mtchd.size - 1).times do |i|
            coked_str << mtchd[i+1].send(prgm.fetch('clrs').fetch(i))
          end
          coked_str
        else
          line
        end
      }
    end
  end
end
