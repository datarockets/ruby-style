# Layout

## Layout/ArrayAlignmentExtended

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | Yes  | 0.7.0 | -

Here we check if the elements of a multi-line array literal are
aligned.

### Examples

#### EnforcedStyle: with_fixed_indentation (default)

```ruby
# good

array = [1, 2, 3,
  4, 5, 6]

# bad

array = [1, 2, 3,
         4, 5, 6]
```

#### EnforcedStyle: with_first_argument

```ruby
# good

array = [1, 2, 3,
         4, 5, 6]
array = ['run',
         'forrest',
         'run']

# bad

array = [1, 2, 3,
  4, 5, 6]
array = ['run',
     'forrest',
     'run']
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `with_first_parameter` | `with_first_parameter`, `with_fixed_indentation`
IndentationWidth | `<none>` | Integer

# Style

## Style/NestedInterpolation

Enabled by default | Safe | Supports autocorrection | VersionAdded | VersionChanged
--- | --- | --- | --- | ---
Enabled | Yes | No | 0.8.0 | -

This cop checks nested interpolations

### Example

```ruby
# bad
"Hello, #{user.blank? ? 'guest' : "dear #{user.name}"}"

# good
user_name = user.blank? ? 'guest' : "dear #{user.name}"
"Hello, #{user_name}"
```
