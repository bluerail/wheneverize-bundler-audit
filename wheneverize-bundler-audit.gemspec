# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wheneverize/bundler/audit'

Gem::Specification.new do |spec|
  spec.name          = 'wheneverize-bundler-audit'
  spec.version       = Wheneverize::Bundler::Audit::VERSION
  spec.authors       = ['Rene van Lieshout']
  spec.email         = ['rene@bluerail.nl']

  spec.summary       = 'Schedules daily task for Gemfile audit'
  spec.description   = 'Schedules daily task using whenever for Gemfile ' \
                       'audit using bundler-audit that just raises an ' \
                       'exception for your default exception notifier to catch'
  spec.homepage      = 'https://www.bluerail.nl'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |file|
    file.match(%r{^(test|spec|features)/}) ||
      file.match(%r{.gem$})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'

  # Specific versions, cause we monkey patch whenever and
  # didn't test agains others (yet)
  spec.add_runtime_dependency 'bundler-audit', '~> 0.4.0'
  spec.add_runtime_dependency 'whenever', '~> 0.9.4'
end
