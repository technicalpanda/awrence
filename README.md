=======
awrence
========

Have you ever needed to automatically convert Rubyish `snake_case` to JSON-style `camelBack` or `CamelCase` hash keys?

Awrence to the rescue.

This gem recursively converts all snake_case keys in a hash structure to camelBack or CamelCase.

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

```ruby
Awrence.acronyms = { "url" => "URL", "id" => "ID" }
my_hash = {"user_url" => "http://a.com", "user_id" => 2}
camel_hash = my_hash.to_camel_keys
# => {"UserURL"=>"http://a.com", "UserID"=>2}

camel_hash = my_hash.to_camelback_keys
# => {"userURL"=>"http://a.com", "userID"=>2}
```

The acronym will be ignored when it's the first word and `to_camelback_keys` is called.

## Limitations

* Unlike the original [T.E. Lawrence](http://en.wikipedia.org/wiki/T._E._Lawrence), the awrence gem is non-destructive to Hashes, Turks, or the nascent political aspirations of oppressed peoples. There is no `Hash#to_camel_keys!` form.

# Going the other way

If you've already got `CamelCase` and need to `snake_case` it, you are encouraged to try
the [Plissken](http://github.com/futurechimp/plissken) gem.

## Contributing to awrence

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2013 Dave Hrycyszyn. See LICENSE.txt for
further details.
