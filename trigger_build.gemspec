# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trigger_build/version'

Gem::Specification.new do |spec|
  spec.name          = 'trigger_build'
  spec.version       = TriggerBuild::VERSION
  spec.authors       = ['Ryan Davis']
  spec.email         = ['void@rdavis.xyz']
  spec.executables   << 'trigger_build'

  spec.summary       = 'Trigger TravisCI builds'
  spec.description   = 'Trigger TravisCI builds with ease'
  spec.homepage      = 'https://github.com/MYOB-Technology/trigger_build'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.require_paths = ['lib']

  spec.add_dependency 'slop', '~> 4.4'
  spec.add_dependency 'httparty', '~> 0.14'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end