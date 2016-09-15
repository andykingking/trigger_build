# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trigger_build/version'

Gem::Specification.new do |spec|
  spec.name          = 'trigger_build'
  spec.version       = TriggerBuild::VERSION
  spec.authors       = ['Ryan Davis']
  spec.email         = ['ryan.davis@myob.com']
  spec.executables   = ['trigger_build']

  spec.summary       = 'Trigger Travis CI builds'
  spec.description   = 'Trigger Travis CI builds with ease'
  spec.homepage      = 'https://github.com/MYOB-Technology/trigger_build'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.bindir        = 'bin'
  spec.require_paths = ['lib']

  spec.add_dependency 'git', '~> 1.3'
  spec.add_dependency 'httparty', '~> 0.14'
  spec.add_dependency 'slop', '~> 4.4'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.42'
  spec.add_development_dependency 'simplecov', '~> 0.12'
end
