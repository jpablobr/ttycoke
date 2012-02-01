require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'

namespace :test do
  Rake::TestTask.new do |t|
    t.name = "minitest"
    t.libs << "test"
    t.test_files = FileList['test/ttycoke/test_*.rb', 'test/test_*.rb']
    t.verbose = true
  end
end

desc "install .ttycokerc and .ttycoke.d into user's home directory"
task :setup do
  if File.exist?(File.join(ENV['HOME'], ".ttycokerc"))
    puts "#{File.join(ENV['HOME'], '.ttycokerc')} already exist."
  else
    puts "Coping .ttycokerc and .ttycoke.d to $HOME directory"
    system %Q{cp "$PWD/config/config.yaml" "$HOME/.ttycokerc"}
    system %Q{cp -fr "$PWD/config/.ttycoke.d" "$HOME/.ttycoke.d"}
    puts "done."
  end
end

task :default => "test:minitest"
