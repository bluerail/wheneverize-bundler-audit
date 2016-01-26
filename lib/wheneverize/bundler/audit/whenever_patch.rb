require 'whenever'

module Wheneverize
  module Bundler
    module Audit
      class WheneverPatch
        def self.apply!
          Whenever::JobList.class_eval do
            alias_method :original_initialize, :initialize

            def initialize(options)
              original_initialize(options).tap do
                every :day do
                  runner 'Wheneverize::Bundler::Audit.run!'
                end
              end
            end
          end
        end
      end
    end
  end
end
