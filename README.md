# NyplLogFormatter

[![Build Status](https://travis-ci.org/NYPL/ruby_nypl_log_formatter.svg?branch=master)](https://travis-ci.org/NYPL/ruby_nypl_log_formatter)

This is a logger that logs according to [NYPL's agreed-upon format](https://github.com/NYPL/engineering-general/blob/master/standards/logging.md).  
It is a subclass of the stdlib Logger class, so it works exactly as a regular Logger does.
The only advantage to subclassing is that we can bake in [custom formatting](https://stackoverflow.com/questions/14382252/how-to-format-ruby-logger).

## Ruby Version Support

Our [`.travis.yml`]('.travis.yml') tests against multiple Ruby versions.
Feel free to add more.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nypl_log_formatter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nypl_log_formatter

## Usage

```ruby
require 'nypl_log_formatter'

my_logger = NyplLogFormatter.new('path/to/file.log')
my_logger.info('this will log JSON')
my_logger.warn('So will this')

# Contents of file.log
  # Logfile created on 2018-01-17 15:51:31 -0500 by logger.rb/61378
  #{"level":"INFO","message":"this will log JSON","timestamp":"2018-01-17T15:51:53.481-0500"}
  #{"level":"WARN","message":"So will this","timestamp":"2018-01-17T15:51:54.279-0500"}
```

### Instantiating A Logger

The constructor (and all other methods, really) of NyplLogFormatter are the same as a Logger.
Which means you can do EVERYTHING you can with a `Logger`, in the same way.
That includes:

* Setting Log level
* Using `STDOUT` instead of a file.
* Setting log rotation.

For more info see your ruby version's documentation for the `Logger` class.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nypl/ruby_nypl_log_formatter.
