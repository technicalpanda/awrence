# frozen_string_literal: true

require "awrence/methods"
require "awrence/ext/array/to_camel_keys"
require "awrence/ext/hash/to_camel_keys"

module Awrence
  class << self
    attr_writer :acronyms

    def acronyms
      @acronyms ||= {}
    end
  end
end
