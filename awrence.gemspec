# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "awrence/version"

Gem::Specification.new do |s|
  s.name        = "awrence"
  s.version     = Awrence::VERSION
  s.authors     = ["Dave Hrycyszyn", "Stuart Chinery"]
  s.email       = ["dhrycyszyn@zonedigital.com"]
  s.homepage    = "https://github.com/futurechimp/awrence"
  s.summary     = "Camelize your snake keys when working with JSON APIs"
  s.description = "Have you ever needed to automatically convert Ruby-style snake_case to CamelCase "\
  "or camelBack hash keys?\n\nAwrence to the rescue.\n\nThis gem recursively converts all snake_case "\
  "keys in a hash structure to camelBack."
  s.license = "MIT"

  s.files = Dir[
    "lib/**/*",
    "MIT-LICENSE",
    "Rakefile",
    "README.md",
    "VERSION"
  ]

  s.add_development_dependency "minitest", "~> 5.0"
  s.add_development_dependency "minitest-fail-fast", "~> 0.1"
  s.add_development_dependency "minitest-reporters", "~> 1.3"
  s.add_development_dependency "rake", "~> 12.0"
end
