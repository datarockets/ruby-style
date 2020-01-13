# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::RepeatedDescribeBody do
  subject(:cop) { described_class.new }

  it "registers an offense for repeated describe body" do
    expect_offense(<<-RUBY)
      describe 'doing x' do
      ^^^^^^^^^^^^^^^^^^^^^ Don't repeat describe block body
        it { cool_assert }
      end

      describe 'doing y' do
      ^^^^^^^^^^^^^^^^^^^^^ Don't repeat describe block body
        it { cool_assert }
      end
    RUBY
  end
end
