# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zmby/version'

Gem::Specification.new do |spec|
  spec.name          = "zmby"
  spec.version       = Zmby::VERSION
  spec.authors       = ["Derek Kniffin"]
  spec.email         = ["oddityoverseer13@gmail.com"]
  spec.summary       = 'Text-based zombie survival game'
  spec.description   = ''
  spec.homepage      = ""
  spec.license       = ""

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency 'gosu_tiled'
end
