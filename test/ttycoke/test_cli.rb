# -*- encoding: utf-8 -*-
require 'test_helper'

class CLITest < MiniTest::Unit::TestCase
  def setup
    assert @cli = TTYCoke::CLI.new
  end
end
