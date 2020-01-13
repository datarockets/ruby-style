# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::RepeatedContextDescription do
  subject(:cop) { described_class.new }

  it "registers an offense for repeated context description" do
    expect_offense(<<-RUBY)
      context 'when foo' do
      ^^^^^^^^^^^^^^^^^^^^^ Don't repeat context descriptions
        # example group
      end

      context 'when foo' do
      ^^^^^^^^^^^^^^^^^^^^^ Don't repeat context descriptions
        # example group
      end
    RUBY
  end
end
