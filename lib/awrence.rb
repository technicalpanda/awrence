require File.dirname(__FILE__) + "/awrence/ext/hash/to_camel_keys"

module Awrence
  class << self
    attr_writer :acronyms

    def acronyms
      @acronyms ||= {}
    end
  end
end
