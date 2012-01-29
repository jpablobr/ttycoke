require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'

namespace :test do
  Rake::TestTask.new do |t|
    t.name = "minitest"
    t.libs << "lib"
    t.pattern = "test/**/test_*.rb"
  end
end

desc "install the rc file into user's home directory"
task :setup do
  if File.exist?(File.join(ENV['HOME'], ".ttycokerc"))
    puts "#{File.join(ENV['HOME'], '.ttycokerc')} already exist."
  else
    puts "Coping .ttycokerc to $HOME directory"
    system %Q{cp "$PWD/config/config.yaml" "$HOME/.ttycokerc"}
    puts "done."
  end
end

task :default => "test:minitest"
