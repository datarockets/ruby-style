# frozen_string_literal: true

RSpec.describe DatarocketsStyle::Cop::RSpec::PreferBeforeOverSetup do
  subject(:cop) { described_class.new }

  context "when using `do ... end` block syntax" do
    it "accepts before call" do
      expect_no_offenses <<~RUBY
        before do
          allow(post).to receive(:publish!)
        end
      RUBY
    end

    it "registers an offence on setup call" do
      expect_offense <<~RUBY
        setup do
        ^^^^^^^^ Use `before` instead of `setup`.
          allow(post).to receive(:publish!)
        end
      RUBY
    end
  end

  context "when sing curly braces block syntax" do
    it "accepts before call" do
      expect_no_offenses <<~RUBY
        before {
          allow(post).to receive(:publish!)
        }
      RUBY
    end

    it "registers an offence on setup call" do
      expect_offense <<~RUBY
        setup {
        ^^^^^^^ Use `before` instead of `setup`.
          allow(post).to receive(:publish!)
        }
      RUBY
    end
  end

  context "when autocorrecting offences" do
    it "replaces `setup` to `before`" do
      expect(autocorrect_source("setup do @one = 1 end")).to eq("before do @one = 1 end")
    end
  end
end
