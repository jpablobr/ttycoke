# -*- encoding: utf-8 -*-
require_relative '../test_helper'

class CLITest < MiniTest::Unit::TestCase
  def setup
    @cli = TTYCoke::CLI.new
  end
end
