# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::RepeatedContextBody do
  subject(:cop) { described_class.new }

  it "registers an offense for repeated describe body" do
    expect_offense(<<-RUBY)
      context 'when x' do
      ^^^^^^^^^^^^^^^^^^^ Don't repeat context block body
        it { cool_assert }
      end

      context 'when y' do
      ^^^^^^^^^^^^^^^^^^^ Don't repeat context block body
        it { cool_assert }
      end
    RUBY
  end
end
