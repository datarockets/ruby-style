# Style Guide

In datarockets we enforce a community [Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide).

This is a small list of differences which we have when compared with community style guide:

## Table of contents

* [Bundler](#Bundler)
* [Style](#Style)
* [Rspec](#Rspec)

## Bundler

* <a name="bundler-add-once"></a>
  A Gem's requirements should be listed only once in a Gemfile
  <sup>[[link](#bundler-add-once)]</sup>

* <a name="bundler-ordering"></a>
  Gems should be alphabetically sorted within groups. Also you can use a line comment as a group separator.
  <sup>[[link](#bundler-ordering)]</sup>

## Style

* <a name="style-line-length"></a>
  Limit lines to 120 characters.
  <sup>[[link](#style-line-length)]</sup>

* <a name="style-string-quotes"></a>
  Adopt a consistent string literal quoting style.
  <sup>[[link](#style-string-quotes)]</sup>

* <a name="style-hash-aligning"></a>
  If elements of a hash literal span more than one line we're aligning them by keys.
  <sup>[[link](#style-hash-aligning)]</sup>


```ruby
# bad
{
  foo: bar,
   ba: baz
}
{
  foo: bar,
  ba:  baz
}

# good
{
  foo: bar,
  ba: baz
}
```

* <a name="style-keyword-arguments-aligning"></a>
  There is one exception in the rule above when the hash literal is passed as method argument.
  In this case we just use an indentation level.
  <sup>[[link](#style-keyword-arguments-aligning)]</sup>

```ruby
# bad
do_something(foo: 1,
             bar: 2)

# good
do_something(foo: 1,
  bar: 2)
```

* <a name="style-parameters-aligning"></a>
  The parameters on a multi-line method call or definition are aligning by an indentation level.
  <sup>[[link](#style-parameters-aligning)]</sup>

  **Recommended:** write each parameter on the separate line.

```ruby
# bad

def foo(bar, baz,
        kek, lol)
  123
end

# bad

def foo(
  bar,
     baz)
  123
end

# good

def foo(bar, baz,
  kek, lol)
  123
end

# better

def foo(
  bar,
  baz,
  kek,
  lol
)
  123
end
```

* <a name="style-end-aligning"></a>
  The `end` shall be aligned with the left-hand-side of the variable assignment. But we prefer not to use code blocks with `end` for variable assignment and prefer move it into the separate methods.
  <sup>[[link](#style-end-aligning)]</sup>

```ruby
# bad

variable = if true
           end

variable = array.map do |value|
                    value
                  end

# good

variable = if true
end

variable =
  if true
  end

variable = array.map do |value|
  value
end

# better

variable = condition_value

def condition_value(*args)
  if true
  end
end

variable = values_from_array(array)

def values_from_array(array)
  array.map do |value|
    value
  end
end

```

* <a name="style-method-indentations"></a>
  We're prefering a ruby style for methods indentations, not rails. You can check it [here](https://github.com/rubocop-hq/ruby-style-guide#indent-public-private-protected).
  <sup>[[link](#style-method-indentations)]</sup>

```ruby
# bad
class A
  def test
    puts "hello"
     puts "world"
  end
end

# bad
class A
  def test
    puts "hello"
    puts "world"
  end

  protected

    def foo
    end

  private

    def bar
    end
end

# good
class A
  def test
    puts "hello"
    puts "world"
  end
end

# good
class A
  def test
    puts "hello"
    puts "world"
  end

  protected

  def foo
  end

  private

  def bar
  end
end
```

* <a name="style-hash-spaces"></a>
  For hash literals not to add scapes after `{` or before `}`. We want to have the advantage of adding visual difference between block and hash literals.
  <sup>[[link](#style-hash-spaces)]</sup>

```ruby
# bad
h = { a: 1, b: 2 }
Array.new(3) {|i| i + 1}

# good
h = {a: 1, b: 2}
Array.new(3) { |i| i + 1 }
```

* <a name="style-rescued-variable-name"></a>
  Use `error` as a variable name on processing exceptions.
  <sup>[[link](#style-rescued-variable-name)]</sup>

```ruby
# bad
begin
  # do something
rescue MyException => e
  # do something
end

# good
begin
  # do something
rescue MyException => error
  # do something
end
```


* <a name="style-empty-method"></a>
  Write empty methods in an expanded way.
  <sup>[[link](#style-empty-method)]</sup>

```ruby
# bad
def foo(bar); end

def self.foo(bar); end

# good
def foo(bar)
end

def self.foo(bar)
end
```

* <a name="style-cached-instance-variable-name"></a>
  Use leading underscores in cached instance variable name
  <sup>[[link](#style-cached-instance-variable-name)]</sup>

```ruby
# bad
def foo
  @something ||= calculate_expensive_thing
end

# bad
def foo
  @foo ||= calculate_expensive_thing
end

# good
def foo
  @_foo ||= calculate_expensive_thing
end
```

* <a name="style-magic-link"></a>
  There are not any requried rules for `frozen_string_literal` magic url.
  Set up [this cop](https://rubocop.readthedocs.io/en/latest/cops_style/#stylefrozenstringliteralcomment) depends  on the project.
  So set up it on the local rubocop config manually.
  <sup>[[link](#style-magic-link)]</sup>

* <a name="style-braces-around-hash-params"></a>
  Not to use braces around the last hash literal parameter.
  But requires braces if the second to last parameter is also a hash literal.
  <sup>[[link](#style-braces-around-hash-params)]</sup>

```ruby
# bad
some_method(x, y, {a: 1, b: 2})
some_method(x, y, {a: 1, b: 2}, a: 1, b: 2)

# good
some_method(x, y, a: 1, b: 2)
some_method(x, y, {a: 1, b: 2}, {a: 1, b: 2})
```

## Rspec

* <a name="rspec-betterrspec"></a>
  We're happy to use [better spec rules](http://www.betterspecs.org/) for improving our tests.
  <sup>[[link](#rspec-betterrspec)]</sup>

* <a name="rspec-file-length"></a>
  We're not limiting a length of rspec files.
  <sup>[[link](#rspec-file-length)]</sup>

* <a name="rspec-subject"></a>
  Each subject should be named and we should not use `subject` in our test cases.
  Prefer to use `is_expected` that `expect(subject_name)` for small tests.
  <sup>[[link](#rspec-subject)]</sup>

```ruby
# bad
subject { service.call }

it "test" do
  expect(subject).to eq value
end

# ok
subject(:service_call) { service.call }

it "test" do
  expect(service_call).to eq value
end

# better
subject { service.call }

it "test" do
  is_expected.to eq value
end
```

* <a name="rspec-context-wording"></a>
  When describing a context, start its description with "when", "for", with" or "without".
  <sup>[[link](#rspec-context-wording)]</sup>

```ruby
  # bad
context "the display name not present" do
  # ...
end

# good
context "when the display name is not present" do
  # ...
end
```
