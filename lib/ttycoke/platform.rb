# -*- encoding: utf-8 -*-
require 'rbconfig'
module TTYCoke
  class Platform
    class << self
      def tiger?
        platform.include?("darwin8")
      end

      def leopard?
        platform.include?("darwin9")
      end

      [:darwin, :bsd, :freebsd, :linux].each do |type|
        define_method("#{type}?") do
          platform.include?(type.to_s)
        end
      end

      def windows?
        %W[mingw mswin].each do |text|
          return true if platform.include?(text)
        end

        false
      end

      def platform
        RbConfig::CONFIG["host_os"].downcase
      end
    end
  end
end
