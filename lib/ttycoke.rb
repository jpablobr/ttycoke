# -*- encoding: utf-8 -*-
require 'ttycoke/ansi'
include TTYCoke::ANSI

module TTYCoke
  autoload :CLI,      'ttycoke/cli'
  autoload :Log,      'ttycoke/log'
  autoload :Run,      'ttycoke/run'
  autoload :Parser,   'ttycoke/parser'
  autoload :Import,   'ttycoke/import'
  autoload :Config,   'ttycoke/config'
  autoload :Errors,   'ttycoke/errors'
  autoload :Version,  'ttycoke/version'
  autoload :Platform, 'ttycoke/platform'
end
