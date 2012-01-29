# -*- encoding: utf-8 -*-
require_relative '../test_helper'

class ConfigTest < MiniTest::Unit::TestCase
  include TTYCoke::Log

  def setup
    @config = TTYCoke::Config.new(File.dirname(__FILE__) + '/../data/config.yaml')
  end

  def test_find_program
    assert @config.find_program('lsmod')
    refute @config.find_program('do not exist')
  end

  def test_yaml_file_syntax_error
    buggie_test_file = File.dirname(__FILE__) + '/../data/syntax_error_config.yaml'
    exception = assert_raises(TTYCoke::Errors::YamlSyntaxError) {
      TTYCoke::Config.new(buggie_test_file)
    }
  end

end
