# Datarockets::Style [![Gem Version](https://badge.fury.io/rb/datarockets-style.svg)](https://badge.fury.io/rb/datarockets-style)

Datarockets shared style configs and notes of code-style convensions. Based on the [Rubocop](https://github.com/rubocop-hq/rubocop) util.

This config enforces many of the guidelines outlined in the datarockets [Ruby Style Guide](STYLE_GUIDE.md).

## Installation

Add this line to your application's Gemfile:

```ruby
group :test, :development do
  gem 'datarockets-style'
end
```

Or, for a Ruby library, add this to your gemspec:

```ruby
spec.add_development_dependency 'datarockets-style'
```

And then execute:

$ bundle install

## Usage

Create a `.rubocop.yml` with the following directives:

```yaml
inherit_gem:
  datarockets-style:
    - default.yml
```

Now, run:

```bash
$ bundle exec rubocop
```

You do not need to include rubocop directly in your application's dependencies. Datarockets-style will include a specific version of `rubocop` and `rubocop-rspec` that is shared across all projects.

## Changelog

Datarockets Style's changelog is available [here](CHANGELOG.md).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/datarockets/datarockets-style. If you'd like to contribute to our RuboCop config and code-style rules, please take the time to go through our short [contribution guidelines](CONTRIBUTING.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Datarockets::Style project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
