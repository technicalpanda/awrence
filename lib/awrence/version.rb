# frozen_string_literal: true

module Awrence
  version_file = File.join(File.dirname(__FILE__), "../../VERSION")
  VERSION = File.read(version_file).split("\n").first
end
