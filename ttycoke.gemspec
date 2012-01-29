# -*- coding: utf-8 -*-
$:.unshift File.expand_path("../lib", __FILE__)
require 'ttycoke/version'
Gem::Specification.new do |s|
   s.name = 'ttycoke'
   s.version = TTYCoke::Version::STRING
   s.platform = Gem::Platform::RUBY
   s.date = '2012-01-01'
   s.authors = ["José Pablo Barrantes"]
   s.email = 'xjpablobrx@gmail.com'
   s.summary = 'TTYCoke enables coloring on ANSI terminals based on regular expressions.'
   s.homepage = 'http://jpablobr.github.com/ttycoke'
  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path  = 'lib'
end
