# frozen_string_literal: true

module Awrence
  module Methods
    # Recursively converts Rubyish snake_case hash keys to camelBack JSON-style
    # hash keys suitable for use with a JSON API.
    #
    def to_camelback_keys(value = self)
      process_value(:to_camelback_keys, value, first_upper: false)
    end

    # Recursively converts Rubyish snake_case hash keys to CamelCase JSON-style
    # hash keys suitable for use with a JSON API.
    #
    def to_camel_keys(value = self)
      process_value(:to_camel_keys, value, first_upper: true)
    end

    private

    def camelize_key(key, first_upper: true)
      case key
      when Symbol
        camelize(key.to_s, first_upper: first_upper).to_sym
      when String
        camelize(key, first_upper: first_upper)
      else
        key # Awrence can't camelize anything except strings and symbols
      end
    end

    def camelize(snake_word, first_upper: true)
      if first_upper
        str = snake_word.to_s
        str = gsubbed(str, /(?:^|_)([^_\s]+)/)
        gsubbed(str, %r{/([^/]*)}, "::")
      else
        parts = snake_word.split("_", 2)
        parts[0] << camelize(parts[1]) if parts.size > 1
        parts[0] || ""
      end
    end

    def gsubbed(str, pattern, extra = "")
      str.gsub(pattern) do
        extra + (Awrence.acronyms[Regexp.last_match(1)] || Regexp.last_match(1).capitalize)
      end
    end

    def process_value(method, value, first_upper: true)
      case value
      when Array
        value.map { |v| send(method, v) }
      when Hash
        value.map { |k, v| [camelize_key(k, first_upper: first_upper), send(method, v)] }.to_h
      else
        value
      end
    end
  end
end
