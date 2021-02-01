# Awrence

[![Gem Version](https://badge.fury.io/rb/awrence.svg)](https://badge.fury.io/rb/awrence)
![CI](https://github.com/technicalpanda/awrence/workflows/CI/badge.svg)

Have you ever needed to automatically convert Rubyish `snake_case` to JSON-style `camelBack` or `CamelCase` hash keys? 

Awrence to the rescue!

This gem recursively converts all snake_case keys in a hash structure to camelBack or CamelCase.

## Installation

Add this to your Gemfile:

```ruby
gem "awrence"
```

Or install it yourself as:

```bash
gem install awrence
```

## Usage

```ruby
my_hash = {"first_key" => 1, "foo_bars" => [{"baz_baz" => "value"}, {"blah_blah" => "value"}]}
camel_hash = my_hash.to_camel_keys
# => {"FirstKey" => 1, "FooBars" => [{"BazBaz" => "value"}, {"BlahBlah" => "value"}]}

# OR

camel_hash = my_hash.to_camelback_keys
# => {"firstKey" => 1, "fooBars" => [{"bazBaz" => "value"}, {"blahBlah" => "value"}]}
```

Awrence works on either string keys or symbolized keys. It has no dependencies, as it has its own `camelize` method lifted out of ActiveSupport.

### Acronyms

You can set acronyms that Awrence will now check against when converting the keys.

```ruby
Awrence.acronyms = { "url" => "URL", "id" => "ID" }

my_hash = { "user_url" => "http://a.com", "user_id" => 2 }
camel_hash = my_hash.to_camel_keys
# => { "UserURL" => "http://a.com", "UserID" => 2 }

camel_hash = my_hash.to_camelback_keys
# => { "userURL" => "http://a.com", "userID" => 2 }
```

The acronym will be ignored when it's the first word and `to_camelback_keys` is called.

```ruby
Awrence.acronyms = { "id" => "ID" }

my_hash = { "id" => 2 }
camel_hash = my_hash.to_camel_keys
# => { "ID" => 2 }

camel_hash = my_hash.to_camelback_keys
# => { "id" => 2 }
```

## Limitations

* There is no `Hash#to_camel_keys!` form.

# Going the other way

If you've already got `CamelCase` and need to `snake_case` it, you are encouraged to try
the [Plissken](http://github.com/futurechimp/plissken) gem.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/technicalpanda/awrence. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting with this project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/technicalpanda/awrence/blob/main/CODE_OF_CONDUCT.md).
