# Rspec Style Guide

This style guide recommends best practices for writing a clear Rspec tests and enjoy this process.

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

* <a name="rspec-expect-change"></a>
  Prefer using blocks for change matcher than method calls.
  <sup>[[link](#rspec-expect-change)]</sup>

```ruby
# bad
expect { run }.to change(Foo, :bar)

# good
expect { run }.to change { Foo.bar }
```
