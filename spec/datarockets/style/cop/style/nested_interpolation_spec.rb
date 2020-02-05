RSpec.describe Datarockets::Style::Cop::Style::NestedInterpolation do
  subject(:cop) { described_class.new }

  it "accepts single interpolation" do
    expect_no_offenses('"dear #{user.name}"')
  end

  it "accepts two single interpolation" do
    expect_no_offenses('"Hello #{user1.name} and #{user2.name}"')
  end

  it 'registers an offense for "Hello, #{user.blank? ? guest : "dear #{user.name}"}"' do
    expect_offense(<<~'RUBY')
      "Hello, #{user.blank? ? 'guest' : "dear #{user.name}"}"
                                              ^^^^^^^^^^^^ Redundant nested interpolation.
    RUBY
  end

  it 'registers an offense for %|Hello, #{user.blank? ? guest : "dear #{user.name}"|' do
    expect_offense(<<~'RUBY')
      %|Hello, #{user.blank? ? 'guest' : "dear #{user.name}"}|
                                               ^^^^^^^^^^^^ Redundant nested interpolation.
    RUBY
  end

  it 'registers an offense for %Q(Hello, #{user.blank? ? guest : "dear #{user.name}")' do
    expect_offense(<<~'RUBY')
      %Q(Hello, #{user.blank? ? 'guest' : "dear #{user.name}"})
                                                ^^^^^^^^^^^^ Redundant nested interpolation.
    RUBY
  end

  it 'registers an offense for ["Hello, #{user.blank? ? guest : "dear #{user.name}"}"]' do
    expect_offense(<<~'RUBY')
      ["Hello, #{user.blank? ? 'guest' : "dear #{user.name}"}", 'foo']
                                               ^^^^^^^^^^^^ Redundant nested interpolation.
    RUBY
  end
end
