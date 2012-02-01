# -*- encoding: utf-8 -*-
require 'yaml'

module TTYCoke
  class Config
    include TTYCoke::Log

    def initialize(config_file=ENV['HOME'] + "/.ttycokerc")
      log_rescue(self, __method__, caller, TTYCoke::Errors::YamlSyntaxError) {
        @files = {
          init: config_file,
          tty_coke: File.dirname(__FILE__) + '/../../config/config.yaml'
        }
        raw_yaml = YAML::load(File.open(File.expand_path(file)))
        paths = raw_yaml.fetch('import')
        importer = File.dirname(file)
        @config = TTYCoke::Import.import(raw_yaml, paths, {}, importer)
      }
    end

    def find_program prgm
      if @config.keys.include?(prgm)
        @config.fetch(prgm)
      else
        false
      end
    end

    def file
      log_rescue(self, __method__, caller) {
        if FileTest.exist?(@files.fetch(:init))
          @files.fetch(:init)
        else
          @files.fetch(:tty_coke)
        end
      }
    end
  end
end
