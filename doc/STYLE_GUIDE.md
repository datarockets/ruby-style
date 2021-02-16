# Style Guide

In datarockets we enforce a community [Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide).

Also, we have some new rules for writing Rails applications and Rspec test. You can find it by next links:

- [Rails Style Guide](doc/STYLE_GUIDE_RAILS.md)
- [Rspec Style Guide](doc/STYLE_GUIDE_RSPEC.md)

This is a small list of differences which we have when compared with community style guide:

## Table of contents

* [Bundler](#Bundler)
* [Style](#Style)
* [Rspec](#Rspec)

## Bundler

* <a name="bundler-add-once"></a>
  A Gem's requirements should be listed only once in a Gemfile.
  <sup>[[link](#bundler-add-once)]</sup>

* <a name="bundler-ordering"></a>
  Gems should be alphabetically sorted within groups. Also, you can use a line comment as a group separator.
  <sup>[[link](#bundler-ordering)]</sup>

## Style

* <a name="style-line-length"></a>
  Limit lines to 120 characters.
  <sup>[[link](#style-line-length)]</sup>

* <a name="style-string-quotes"></a>
  Adopt a consistent string literal quoting style.
  <sup>[[link](#style-string-quotes)]</sup>

* <a name="style-nested-interpolation"></a>
  Avoid using nested interpolation.
   <sup>[[link](#style-nested-interpolation)]</sup>

```ruby
# bad
"Hello, #{user.blank? ? 'guest' : "dear #{user.name}"}"

# good
user_name = user.blank? ? 'guest' : "dear #{user.name}"
"Hello, #{user_name}"
```

* <a name="style-hash-aligning"></a>
  If elements of a hash literal span more than one line, we're aligning them by keys.
  Also, the first hash key is aligned by an indentation level.
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

{
    foo: bar,
  ba: baz
}

{
  foo: {
         bar: bar,
         ba: baz
       }
}

method_call({
               its_like: :this
             })

# good
{
  foo: bar,
  ba: baz
}

{
  foo: {
    bar: bar,
    ba: baz
  }
}

method_call({
  no: :difference
})
```

* <a name="style-arguments-aligning"></a>
  All arguments on a multi-line method definition are aligning by an indentation level.
  This rule works as for keyword arguments, as for usual arguments.
  <sup>[[link](#style-arguments-aligning)]</sup>

```ruby
# bad
do_something(foo: 1,
             bar: 2)

# good
do_something(foo: 1,
  bar: 2)

# good
foo :bar,
  :baz

# bad
foo :bar,
    :baz
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

* <a name="style-array-aligning"></a>
  The elements of a multi-line array are aligning by an indentation level.
  <sup>[[link](#style-array-aligning)]</sup>

```ruby
# bad

array = [1, 2, 3,
         4, 5, 6]

# bad

array = [1, 2, 3,
      4, 5, 6]

# good

array = [1, 2, 3,
  4, 5, 6]
```

* <a name="style-multiline-method-call-indentation"></a>
  The indentation of the method name part in method calls that span more than one line are aligning by an indentation level.
  <sup>[[link](#style-multiline-method-call-indentation)]</sup>

```ruby
# bad
while myvariable
      .b
  # do something
end

# bad
Thing.a
     .b
     .c

# good
while myvariable
  .b

  # do something
end

# good
Thing.a
  .b
  .c
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
  We're preferring a ruby style for methods indentations, not rails. You can check it [here](https://github.com/rubocop-hq/ruby-style-guide#indent-public-private-protected).
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
  For hash literals not to add spaces after `{` or before `}`. We want to have the advantage of adding visual difference between block and hash literals.
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
  Use leading underscores in cached instance variable name.
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

* <a name="style-trailing-comma-in-arguments"></a>
  Requires a comma after the last argument, but only for parenthesized method calls where each argument is on its own line.
  <sup>[[link](#style-trailing-comma-in-arguments)]</sup>

```ruby
# bad
method(1, 2,)

# good
method(1, 2)

# bad
method(
  1, 2,
  3,
)

# good
method(
  1, 2,
  3
)

# bad
method(
  1, 2, 3,
)

# good
method(
  1, 2, 3
)

# good
method(
  1,
  2,
)
```

* <a name="style-trailing-comma-in-array-literals"></a>
  Requires a comma after last item in an array, but only when each item is on its own line.
  <sup>[[link](#style-trailing-comma-in-array-literals)]</sup>

```ruby
# bad
a = [1, 2,]

# good
a = [1, 2]

# bad
a = [
  1, 2,
  3,
]

# good
a = [
  1, 2,
  3
]

# bad
a = [
  1, 2, 3,
]

# good
a = [
  1, 2, 3
]

# good
a = [
  1,
  2,
]
```

* <a name="style-trailing-comma-in-hash-literal"></a>
  Requires a comma after the last item in a hash.
  <sup>[[link](#style-trailing-comma-in-hash-literal)]</sup>

```ruby
# bad
a = { foo: 1, bar: 2, }

# good
a = { foo: 1, bar: 2 }

# bad
a = {
  foo: 1, bar: 2,
  qux: 3,
}

# good
a = {
  foo: 1, bar: 2,
  qux: 3
}

# bad
a = {
  foo: 1, bar: 2, qux: 3,
}

# good
a = {
  foo: 1, bar: 2, qux: 3
}

# good
a = {
  foo: 1,
  bar: 2,
}
```

* <a name="style-magic-link"></a>
  There are not any required rules for `frozen_string_literal` magic url.
  Set up [this cop](https://rubocop.readthedocs.io/en/latest/cops_style/#stylefrozenstringliteralcomment) depends on the project.
  So set up it on the local rubocop config manually.
  <sup>[[link](#style-magic-link)]</sup>
