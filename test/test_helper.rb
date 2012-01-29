# -*- encoding: utf-8 -*-
if RUBY_VERSION < "1.9"
  require 'test/unit'
else
  require 'minitest/unit'
  require 'test/unit'
end

$TEST = true

helper_dir = File.dirname(__FILE__)
test_dir = File.dirname(__FILE__) + '/ttycoke'
lib_dir  = File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH.unshift helper_dir, test_dir, lib_dir

require 'ttycoke'
