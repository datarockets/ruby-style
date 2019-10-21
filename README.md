# Datarockets::Style [![Gem Version](https://badge.fury.io/rb/datarockets-style.svg)](https://badge.fury.io/rb/datarockets-style)

Datarockets shared style configs and notes of code-style convensions. Based on the [Rubocop](https://github.com/rubocop-hq/rubocop) util.

This config enforces many of the guidelines outlined in the datarockets [Ruby Style Guide](doc/STYLE_GUIDE.md).

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

```bash
$ bundle install
```

## Usage

Create a `.rubocop.yml` with the following directives:


### Ruby application

This config includes specific rules for Ruby application. It works for Ruby gems and no-Rails applications.

```yaml
inherit_gem:
  datarockets-style:
    - config/ruby.yml
```

### Rails application

For Rails applications, you can use a specific Rails instead of Ruby config

```yaml
inherit_gem:
  datarockets-style:
    - config/rails.yml
```

### Rspec config

For Rspec tests, you can add a special rubocop config

```yaml
inherit_gem:
  datarockets-style:
    - config/ruby.yml
    - config/rspec.yml
```

Now, run:

```bash
$ bundle exec rubocop
```

You do not need to include rubocop directly in your application's dependencies. Datarockets-style will include a specific version of `rubocop` and `rubocop-rspec` that is shared across all projects.

### Configurable cops

There are some areas in which there is no clear consensus in datarockets team regarding a particular style (like string literal quoting).
In such scenarios, all popular styles are acknowledged and it’s up to you to pick one and apply it consistently.
For that just set up these cops before starting of usage.

#### Style/StringLiterals

There are two popular styles in the Ruby community, both of which are considered good - single quotes by default and double quotes by default.
There is no clear consensus about this style in the Ruby community and in the datarockets team.
So we suggest just to set up a [preferable style](https://rubocop.readthedocs.io/en/latest/cops_style/#stylestringliterals) before running this gem.

P.S. The string literals in this gem are using double quotes by default.

##### Tips

For an existing project, we suggest to run rubocop with both styles and choose which has fewer offenses (which is more popular in the current project).


## Changelog

Datarockets Style's changelog is available [here](CHANGELOG.md).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/datarockets/datarockets-style. If you'd like to contribute to our RuboCop config and code-style rules, please take the time to go through our short [contribution guidelines](CONTRIBUTING.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Datarockets::Style project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
