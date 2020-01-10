# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::RepeatedDescribeDescription do
  subject(:cop) { described_class.new }

  it "registers an offense for repeated describes" do
    expect_offense(<<-RUBY)
      describe 'doing x' do
      ^^^^^^^^^^^^^^^^^^^^^ Don't repeat describe descriptions
        # example group
      end

      describe 'doing x' do
      ^^^^^^^^^^^^^^^^^^^^^ Don't repeat describe descriptions
        # example group
      end
    RUBY
  end
end
