# -*- encoding: utf-8 -*-
module TTYCoke
  module Version
    extend self
    MAJOR = 0
    MINOR = 1
    PATCH = 0
    BUILD = 'dev'
    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')
  end
end
