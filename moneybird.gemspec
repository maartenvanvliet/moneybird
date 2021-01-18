# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moneybird/version'

Gem::Specification.new do |spec|
  spec.name          = "moneybird"
  spec.version       = Moneybird::VERSION
  spec.authors       = ["Maarten van Vliet"]
  spec.email         = ["maartenvanvliet@gmail.com"]

  spec.summary       = %q{Library to interface with Moneybird API}
  spec.description   = %q{Library to interface with Moneybird API: http://developer.moneybird.com/}
  spec.homepage      = "https://github.com/maartenvanvliet/moneybird"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", '>= 0.12'
  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "link_header", "~> 0.0.8"

  spec.add_development_dependency "bundler", [">= 1.11", "< 3.0"]
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "simplecov", "= 0.21.2"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "webmock", "~> 3.1"
end
