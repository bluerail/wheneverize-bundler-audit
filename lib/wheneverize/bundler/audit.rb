require 'wheneverize/bundler/audit/version'
require 'wheneverize/bundler/audit/whenever_patch'
require 'bundler/audit/scanner'
require 'bundler/audit/database'

Wheneverize::Bundler::Audit::WheneverPatch.apply!

module Wheneverize
  module Bundler
    module Audit
      class VulnerableError < StandardError; end

      def self.run!
        vulnerabilities = []

        ::Bundler::Audit::Database.update!
        ::Bundler::Audit::Scanner.new.scan(:ignore => []) do |result|
          case result
          when ::Bundler::Audit::Scanner::InsecureSource
            vulnerabilities << "Source URI: #{result.source}"
          when ::Bundler::Audit::Scanner::UnpatchedGem
            vulnerabilities << "#{result.gem}: #{result.advisory.id}"
          end
        end

        unless vulnerabilities.blank?
          raise VulnerableError, vulnerabilities.to_sentence
        end
      end
    end
  end
end
