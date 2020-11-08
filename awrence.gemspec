# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "awrence/version"

Gem::Specification.new do |spec|
  spec.authors = ["Dave Hrycyszyn", "Stuart Chinery"]
  spec.description = "Have you ever needed to automatically convert Ruby-style snake_case to CamelCase or camelBack "\
                     "hash keys?\n\nAwrence to the rescue.\n\nThis gem recursively converts all snake_case keys in a "\
                     "hash structure to camelBack."
  spec.email = ["dhrycyszyn@zonedigital.com", "stuart.chinery@gmail.com"]
  spec.files = Dir["lib/**/*", "MIT-LICENSE", "Rakefile", "README.md", "VERSION"]
  spec.homepage = "https://github.com/futurechimp/awrence"
  spec.license = "MIT"
  spec.name = "awrence"
  spec.required_ruby_version = ">= 2.5"
  spec.summary = "Camelize your snake keys when working with JSON APIs"
  spec.version = Awrence::VERSION

  spec.add_development_dependency "byebug", "~> 11.1"
  spec.add_development_dependency "minitest", "~> 5.14"
  spec.add_development_dependency "minitest-fail-fast", "~> 0.1"
  spec.add_development_dependency "minitest-macos-notification", "~> 0.3"
  spec.add_development_dependency "minitest-reporters", "~> 1.4"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop", "~> 0.82"
end
