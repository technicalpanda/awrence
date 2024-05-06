# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "awrence/version"

Gem::Specification.new do |spec|
  spec.authors = ["Dave Hrycyszyn", "Stuart Chinery"]
  spec.description = "Have you ever needed to automatically convert Ruby-style snake_case to CamelCase or camelBack " \
                     "hash keys?\n\nAwrence to the rescue.\n\nThis gem recursively converts all snake_case keys in a " \
                     "hash structure to camelBack."
  spec.email = ["dave@constructiveproof.com", "code@technicalpanda.co.uk"]
  spec.files = Dir["lib/**/*", "MIT-LICENSE", "Rakefile", "README.md", "VERSION"]
  spec.homepage = "https://github.com/technicalpanda/awrence"
  spec.license = "MIT"
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.name = "awrence"
  spec.required_ruby_version = ">= 3.0"
  spec.summary = "Camelize your snake keys when working with JSON APIs"
  spec.version = Awrence::VERSION
end
