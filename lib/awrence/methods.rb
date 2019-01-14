# frozen_string_literal: true

module Awrence
  module Methods
    # Recursively converts Rubyish snake_case hash keys to camelBack JSON-style
    # hash keys suitable for use with a JSON API.
    #
    def to_camelback_keys(value = self)
      case value
      when Array
        value.map { |v| to_camelback_keys(v) }
      when Hash
        Hash[value.map { |k, v| [camelize_key(k, false), to_camelback_keys(v)] }]
      else
        value
      end
    end

    # Recursively converts Rubyish snake_case hash keys to CamelCase JSON-style
    # hash keys suitable for use with a JSON API.
    #
    def to_camel_keys(value = self)
      case value
      when Array
        value.map { |v| to_camel_keys(v) }
      when Hash
        Hash[value.map { |k, v| [camelize_key(k), to_camel_keys(v)] }]
      else
        value
      end
    end

    private

    def camelize_key(key, first_upper = true)
      if key.is_a? Symbol
        camelize(key.to_s, first_upper).to_sym
      elsif key.is_a? String
        camelize(key, first_upper)
      else
        key # Awrence can't camelize anything except strings and symbols
      end
    end

    def camelize(snake_word, first_upper = true)
      if first_upper
        str = snake_word.to_s
        str = gsubbed(str, /(?:^|_)([^_\s]+)/)
        str = gsubbed(str, %r{/([^/]*)}, "::")
        str
      else
        parts = snake_word.split("_", 2)
        parts[0] << camelize(parts[1]) if parts.size > 1
        parts[0] || ""
      end
    end

    def gsubbed(str, pattern, extra = "")
      str = str.gsub(pattern) do
        extra + (Awrence.acronyms[Regexp.last_match(1)] || Regexp.last_match(1).capitalize)
      end

      str
    end
  end
end
