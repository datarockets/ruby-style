# Style Guide

In datarockets we enforce a community [Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide).

This is a small list of differences which we have when compared with community style guide:

## Bundler

* A Gem's requirements should be listed only once in a Gemfile

* Gems should be alphabetically sorted within groups. Also you can use a line comment as a group separator.

## Style

* Limit lines to 80 characters.

* Prefer double-quotes unless your string literal contains " or escape characters you want to suppress.

* If elements of a hash literal span more than one line we're aligning them by keys


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

* There is one exception in the rule above when the hash literal is passed as method argument.
In this case we just use an indentation level.

```ruby
# bad
do_something(foo: 1,
             bar: 2)

# good
do_something(foo: 1,
  bar: 2)
```

* The parameters on a multi-line method call or definition are aligning by an indentation level.

```ruby
# good

def foo(bar,
  baz)
  123
end

def foo(
  bar,
  baz
)
  123
end

# bad

def foo(bar,
        baz)
  123
end

# bad

def foo(
  bar,
     baz)
  123
end
```

* The `end` shall be aligned with the left-hand-side of the variable assignment. But we prefer not to use code blocks with `end` for variable assignment and prefer move it into the separate methods.

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

* We're prefering a ruby style for methods indentations, not rails. You can check it [here](https://github.com/rubocop-hq/ruby-style-guide#indent-public-private-protected)

```ruby
# bad
class A
  def test
    puts 'hello'
     puts 'world'
  end
end

# bad
class A
  def test
    puts 'hello'
    puts 'world'
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
    puts 'hello'
    puts 'world'
  end
end

# good
class A
  def test
    puts 'hello'
    puts 'world'
  end

  protected

  def foo
  end

  private

  def bar
  end
end
```

* For hash literals not to add scapes after `{` or before `}`. We want to have the advantage of adding visual difference between block and hash literals.

```ruby
# bad
h = { a: 1, b: 2 }
Array.new(3) {|i| i + 1}

# good
h = {a: 1, b: 2}
Array.new(3) { |i| i + 1 }
```

## Rspec

* We're happy to use [better spec rules](http://www.betterspecs.org/) for improving our tests.

* We're not limiting a length of rspec files
