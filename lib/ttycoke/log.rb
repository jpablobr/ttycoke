# -*- encoding: utf-8 -*-
require 'logger'

module TTYCoke
  class TTYCokeLogFormat < ::Logger::Formatter
    def call severity, time, program_name, message
      case severity
      when "DEBUG"
        datetime      = time.strftime("%Y-%m-%d %H:%M")
        print_message = "DEBUG".yellow + "--- (#{datetime})\n#{String(message)}"
        [print_message].join("\n") + "\n\n"
      when "ERROR"
        datetime      = time.strftime("%Y-%m-%d %H:%M")
        print_message = "ERROR".red + " --- (#{datetime})\n#{String(message)}"
        [print_message].join("\n") + "\n\n"
      else
        super
      end
    end
  end

  module Log

    $TEST              ||= nil
    @@logger           ||= Logger.new($stderr)
    @@logger.formatter = TTYCokeLogFormat.new
    @@logger.level     = Logger::INFO

    def log_debug cls, mthd, cllr, file, line, ivrs={}, lvrs={}
      # return unless $TEST
      msg = "#{cls.class.name}##{mth}".magenta     +
        "\nCaller => " + "#{cllr[0][/`.*'/][1..-2]}".green +
        "\n---Instance Vars---"
      ivrs.each { |v| msg += "#{v}=".yellow  + eval("#{v}") }
      msg += "\n---local Vars---"
      lvrs.each { |v| msg += "#{v}=".yellow  + eval("#{v}") }
      msg += "\n#{file}:#{line}"
      @@logger.debug(msg)
    end

    def log_error cls, mthd, cllr, e, vars={}
      # return unless $TEST
      status_code = e.status_code if e.respond_to?(:status_code)
      msg = "#{cls.class.name}##{mthd}".magenta     +
        "\nCaller => " + "#{cllr[0][/`.*'/][1..-2]}".green        +
        "\ne.inspect: " + "#{e.inspect}".green                    +
        "\ne.message: " + "#{e.message}".green                    +
        "\ne.status_code: " + "#{status_code}".green              +
        "\n---backtrace---\n"                                     +
        "#{e.backtrace.join("\n")}"                               +
        "\n---Vars---"
      vars.each { |name, value| msg += "\n#{name}: ".yellow + " #{value}" }
      @@logger.error(msg)
    end

    def log_rescue cls, mthd, cllr, ex_type=nil, vars={}
      begin
        result = yield
        status = $? || 0
      rescue Exception => e
        log_error(cls, mthd, cllr, e, vars.merge(status: status)) unless $TEST
        if ex_type
          raise ex_type.new(e)
        else
          raise TTYCoke::Errors::TTYCokeError.new(e)
        end
        exit e.status_code if e.respond_to?(:status_code)
      end
      result
    end

    def log_check_child_exit_status
      result = yield
      status = $? || 0
      unless [0,172].include?(status)
        log_error(self, __method__, caller, e,
            {status: status}) unless $TEST
        raise ArgumentError
        exit e.respond_to?(:status_code) ? e.status_code : Errno::ENOENT::Errno
      end
      result
    end
  end
end
