# frozen_string_literal: true

RSpec.describe DatarocketsStyle::Cop::Style::NestedInterpolation do
  subject(:cop) { described_class.new }

  it "accepts single interpolation" do
    expect_no_offenses('"dear #{user.name}"')
  end

  it "accepts two single interpolation" do
    expect_no_offenses('"Hello #{user1.name} and #{user2.name}"')
  end

  it "accepts interpolation with or logic" do
    expect_no_offenses('"\n#{(lines.join("\n").split(node.source).first || \'\')}"')
  end

  it "registers interpolation into business block" do
    expect_offense(<<~'RUBY')
      "#{assignment.join("\n#{indentation(node)}")}"
                            ^^^^^^^^^^^^^^^^^^^^ Style/NestedInterpolation: Redundant nested interpolation.
    RUBY
  end

  it 'registers an offense for "Hello, #{user.blank? ? guest : "dear #{user.name}"}"' do
    expect_offense(<<~'RUBY')
      "Hello, #{user.blank? ? 'guest' : "dear #{user.name}"}"
                                              ^^^^^^^^^^^^ Style/NestedInterpolation: Redundant nested interpolation.
    RUBY
  end

  it 'registers an offense for %|Hello, #{user.blank? ? guest : "dear #{user.name}"|' do
    expect_offense(<<~'RUBY')
      %|Hello, #{user.blank? ? 'guest' : "dear #{user.name}"}|
                                               ^^^^^^^^^^^^ Style/NestedInterpolation: Redundant nested interpolation.
    RUBY
  end

  it 'registers an offense for %Q(Hello, #{user.blank? ? guest : "dear #{user.name}")' do
    expect_offense(<<~'RUBY')
      %Q(Hello, #{user.blank? ? 'guest' : "dear #{user.name}"})
                                                ^^^^^^^^^^^^ Style/NestedInterpolation: Redundant nested interpolation.
    RUBY
  end

  it 'registers an offense for ["Hello, #{user.blank? ? guest : "dear #{user.name}"}"]' do
    expect_offense(<<~'RUBY')
      ["Hello, #{user.blank? ? 'guest' : "dear #{user.name}"}", 'foo']
                                               ^^^^^^^^^^^^ Style/NestedInterpolation: Redundant nested interpolation.
    RUBY
  end
end
