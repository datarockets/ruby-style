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

* <a name="rspec-example-length"></a>
 A long example is usually more difficult to understand. Consider extracting out some behaviour, e.g. with a `let` block, or a helper method.

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
