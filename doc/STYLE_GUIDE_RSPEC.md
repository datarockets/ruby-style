# Rspec Style Guide

This style guide recommends best practices for writing a clear Rspec tests and enjoy this process.

* <a name="rspec-betterrspec"></a>
  We're happy to use [better spec rules](http://www.betterspecs.org/) for improving our tests.
  <sup>[[link](#rspec-betterrspec)]</sup>

* <a name="rspec-file-length"></a>
  We're not limiting a length of rspec files.
  <sup>[[link](#rspec-file-length)]</sup>

* <a name="rspec-nested-groups"></a>
  Nested context is a nice approach for organizing your code and tests structure.
  So there are not any limits for deep or nested groups.
  <sup>[[link](#rspec-nested-groups)]</sup>

* <a name="rspec-let-count"></a>
  We're not limiting a number of `let` blocks in describe and context blocks.
  <sup>[[link](#rspec-let-count)]</sup>

* <a name="rspec-subject"></a>
  Each subject should be named, and we should not use `subject` in our test cases.
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

* <a name="rspec-example-length"></a>
 A long example is usually more difficult to understand. Consider extracting out some behavior, e.g. with a `let` block, or a helper method.

  <sup>[[link](#rspec-example-length)]</sup>

```ruby
# bad
it 'creates correct deal config object' do
  expect(ZohoUtil::DealConfig).to receive(:new)
    .with(
      deal_name: translated_deal_name,
      stage_uid: zoho_post.stage_uid,
      change_existing_stage: zoho_post.change_existing_stage,
      note_title: translated_note_title,
      note: translated_note
    )

  execute_action
end

# good
let(:service_arguments) do
  {
    deal_name: translated_deal_name,
    stage_uid: zoho_post.stage_uid,
    change_existing_stage: zoho_post.change_existing_stage,
    note_title: translated_note_title,
    note: translated_note
  }
end

it 'creates correct deal config object' do
  expect(ZohoUtil::DealConfig).to receive(:new).with(**service_arguments)
  execute_action
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

* <a name="rspec-message-spies"></a>
  Check spies messages post-factum (after calling some methods).
  <sup>[[link](#rspec-message-spies)]</sup>

```ruby
# bad
expect(foo).to receive(:bar)
foo.bar

# good
foo.bar
expect(foo).to have_received(:bar)
```

* <a name="rspec-prefer-expect"></a>
  Prefer using `expect` instead of `should` matchers.
  <sup>[[link](#rspec-prefer-expect)]</sup>

```ruby
# bad
calculator.compute(line_item).should == 5

# good
expect(calculator.compute(line_item)).to eq(5)
```

**Note:** this is a Part of Rspec configuration. Read more [by link](https://github.com/rubocop-hq/rubocop-rspec#enforcing-should-vs-expect-syntax).

* <a name="rspec-top-rspec"></a>
  Not to use `Rspec.describe` in your test and just write `describe` instead.
  <sup>[[link](#rspec-top-rspec)]</sup>

```ruby
# bad
RSpec.describe MyClass do
  # ...
end

# good
describe MyClass do
  # ...
end
```

**Note:** this is a Part of Rspec configuration. Read more [by link](https://github.com/rubocop-hq/rubocop-rspec#enforcing-an-explicit-rspec-receiver-for-top-level-methods-disabling-monkey-patching).

* <a name="rspec-let-setup"></a>
  We allow using let! in your test, but suggest not to use it for setting up testing data.
  <sup>[[link](#rspec-let-setup)]</sup>

```ruby
# ok
let!(:my_widget) { create(:widget) }

it "counts widgets" do
  expect(Widget.count).to eq(1)
end

# better
before do
  create(:widget)
end

it "counts widgets" do
  expect(Widget.count).to eq(1)
end

# good
let!(:my_widget) { create(:widget) }

it "returns the last widget" do
  expect(Widget.last).to eq my_widget
end
```
