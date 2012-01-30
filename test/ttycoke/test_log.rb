# -*- encoding: utf-8 -*-
require 'test_helper'

class LogTest < MiniTest::Unit::TestCase
  include TTYCoke::Log

  def test_logger_can_optionally_be_redefined
    log_file = File.dirname(__FILE__) + '/../data/my-test-log.log'
    @@logger = Logger.new(log_file)
    assert_match @@logger.inspect, /my-test-log.log/
  end

  def test_log_rescue_method
    exception = assert_raises (ArgumentError) { log_rescue }
    assert_equal("wrong number of arguments (0 for 3)", exception.message)
  end

  def test_log_rescue_method
    exception = assert_raises (ArgumentError) { log_debug }
    assert_equal("wrong number of arguments (0 for 5)", exception.message)
  end
end
