# -*- encoding: utf-8 -*-
require 'tork/config/logdir'
Tork::Config.overhead_load_paths = ['lib', 'test', 'lib/ttycoke', 'test/ttycoke']
Tork::Config.all_test_file_globs = ['test/**/test_*.rb']
Tork::Config.test_file_globbers = {
%r<^(lib/ttycoke|lib)/.+\.rb$> => lambda do |path|
    base = File.basename(path, '.rb')
    "test/**/test_#{base}.rb"
  end,
  %r<^(test/ttycoke|test)/test_.+\.rb$> => lambda {|path| path }
}
