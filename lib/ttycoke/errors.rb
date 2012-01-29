# -*- encoding: utf-8 -*-
module TTYCoke
  module Errors
    class TTYCokeError < StandardError
      @@used_codes = []

      def self.status_code code = nil
        if code
          raise "Status code already in use: #{code}"  if @@used_codes.include?(code)
          @@used_codes << code
        end
        define_method(:status_code) { code }
      end
    end

    class FallbackError < TTYCokeError
      status_code(55)
      def initialize(error)
        super "TTYCoke was not able to fallback to provided program." +
          "Parent error class ::#{error.class.name} (#{error.message})."
      end
    end

    class ProgramNotFoundError < TTYCokeError
      status_code(58)
      def initialize(error)
        super "Program does not exist." +
          "Parent error class ::#{error.class.name} (#{error.message})."
      end
    end

    class YamlSyntaxError < TTYCokeError
      status_code(57)
      def initialize(error)
        super "Maybe a yaml or regex syntax error. " +
          "Parent error class ::#{error.class.name} (#{error.message})."
      end
    end
  end
end
