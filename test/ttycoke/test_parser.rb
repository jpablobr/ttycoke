# -*- encoding: utf-8 -*-
require 'test_helper'

class ParserTest < MiniTest::Unit::TestCase
  def setup
    @config = TTYCoke::Config.new(File.dirname(__FILE__) + '/../data/config.yaml')
    ansi_line_file = File.dirname(__FILE__) + '/../data/ansi_lines.yaml'
    @ansi_lines = YAML::load(File.open(File.expand_path(ansi_line_file)))
  end

  def test_one_regexp_match
    prgm = @config.find_program('lsmod')
    line = @ansi_lines.fetch('lsmod').fetch('line')
    expect = @ansi_lines.fetch('lsmod').fetch('exp')
    assert_equal expect, TTYCoke::Parser.coke!(prgm, line)
  end

  def test_multiple_regexps_match
    prgm = @config.find_program('tail_tork_logs')
    @ansi_lines.fetch('tail_tork_logs')[0].each { |p|
      assert_equal p[1].fetch('exp'), TTYCoke::Parser.coke!(prgm, p[1].fetch('line'))
    }
  end
end
