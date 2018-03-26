# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sensu/translator/version"

Gem::Specification.new do |spec|
  spec.name          = "sensu-translator"
  spec.version       = Sensu::Translator::VERSION
  spec.authors       = ["Sean Porter", "Justin Kolberg"]
  spec.email         = ["portertech@gmail.com", "amd.prophet@gmail.com"]

  spec.summary       = %q{A tool for translating Sensu 1.x config to the Sensu 2.x format.}
  spec.description   = %q{A tool for translating Sensu 1.x config to the Sensu 2.x format.}
  spec.homepage      = "https://github.com/sensu/sensu-translator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
