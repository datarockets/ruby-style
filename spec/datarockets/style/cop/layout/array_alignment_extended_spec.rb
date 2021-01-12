# frozen_string_literal: true

RSpec.describe Datarockets::Style::Cop::Layout::ArrayAlignmentExtended, skip: true do
  subject(:cop) { described_class.new(config) }

  let(:config) do
    RuboCop::Config.new(
      "Layout/ArrayAlignmentExtended" => {
        "EnforcedStyle" => cop_enforced_style,
      },
      "Layout/IndentationWidth" => {
        "Width" => 2,
      }
    )
  end

  context "when aligned with first parameter" do
    let(:cop_enforced_style) { "with_first_parameter" }

    it "accepts single line array" do
      expect_no_offenses("array = [ a, b ]")
    end

    it "accepts several elements per line" do
      expect_no_offenses(<<~RUBY)
        array = [ a, b,
                  c, d ]
      RUBY
    end

    it "accepts aligned array with fullwidth characters" do
      expect_no_offenses(<<~RUBY)
        puts 'Ｒｕｂｙ', [ a,
                           b ]
      RUBY
    end

    context "when basic usage" do
      let(:not_aligned_array) do
        <<~RUBY
          array = [a,
             b,
             ^ Align the elements of an array literal if they span more than one line.
            c,
            ^ Align the elements of an array literal if they span more than one line.
             d]
             ^ Align the elements of an array literal if they span more than one line.
        RUBY
      end

      let(:aligned_array) do
        <<~RUBY
          array = [a,
                   b,
                   c,
                   d]
        RUBY
      end

      it "registers an offense and corrects misaligned array elements" do
        expect_offense(not_aligned_array)

        expect_correction(aligned_array)
      end

      it "accepts aligned array keys" do
        expect_no_offenses(aligned_array)
      end
    end

    context "when using nested arrays" do
      let(:not_aligned_arrays) do
        <<~RUBY
          [:l1,
           [:l2,
             [:l3,
              [:l4]]]]
        RUBY
      end

      it "does not auto-correct array within array with too much indentation" do
        expect_offense(<<~RUBY)
          [:l1,
            [:l2,
            ^^^^^ Align the elements of an array literal if they span more than one line.
              [:l3,
              ^^^^^ Align the elements of an array literal if they span more than one line.
               [:l4]]]]
        RUBY

        expect_correction(not_aligned_arrays)
      end

      it "does not auto-correct array within array with too little indentation" do
        expect_offense(<<~RUBY)
          [:l1,
          [:l2,
          ^^^^^ Align the elements of an array literal if they span more than one line.
            [:l3,
            ^^^^^ Align the elements of an array literal if they span more than one line.
             [:l4]]]]
        RUBY

        expect_correction(not_aligned_arrays)
      end
    end

    context "when arrays with heredoc strings" do
      let(:not_aligned_array) do
        <<~RUBY
          var = [
                 { :type => 'something',
                   :sql => <<EOF
          Select something
          from atable
          EOF
                 },
                { :type => 'something',
                ^^^^^^^^^^^^^^^^^^^^^^^ Align the elements of an array literal if they span more than one line.
                  :sql => <<EOF
          Select something
          from atable
          EOF
                }
          ]
        RUBY
      end

      let(:aligned_array) do
        <<~RUBY
          var = [
                 { :type => 'something',
                   :sql => <<EOF
          Select something
          from atable
          EOF
                 },
                 { :type => 'something',
                   :sql => <<EOF
          Select something
          from atable
          EOF
                 }
          ]
        RUBY
      end

      it "does not indent heredoc strings in autocorrect" do
        expect_offense(not_aligned_array)

        expect_correction(aligned_array)
      end
    end

    context "when each element of array on the new line" do
      let(:aligned_array) do
        <<~RUBY
          array = [
            a,
            b,
            c,
            d
          ]
        RUBY
      end

      let(:not_aligned_array) do
        <<~RUBY
          array = [
            a,
             b,
             ^ Align the elements of an array literal if they span more than one line.
            c,
             d
             ^ Align the elements of an array literal if they span more than one line.
          ]
        RUBY
      end

      it "accepts the first element being on a new row" do
        expect_no_offenses(aligned_array)
      end

      it "registers an offense and corrects misaligned array elements if the first element being on a new row" do
        expect_offense(not_aligned_array)

        expect_correction(aligned_array)
      end
    end
  end

  context "when aligned with fixed indentation" do
    let(:cop_enforced_style) { "with_fixed_indentation" }

    it "accepts single line array" do
      expect_no_offenses("array = [ a, b ]")
    end

    it "accepts several elements per line" do
      expect_no_offenses(<<~RUBY)
        array = [ a, b,
          c, d ]
      RUBY
    end

    it "accepts aligned array with fullwidth characters" do
      expect_no_offenses(<<~RUBY)
        puts 'Ｒｕｂｙ', [ a,
          b ]
      RUBY
    end

    context "when basic usage" do
      let(:not_aligned_array) do
        <<~RUBY
          array = [a,
             b,
             ^ Use one level of indentation for elements following the first line of a multi-line array.
            c,
             d]
             ^ Use one level of indentation for elements following the first line of a multi-line array.
        RUBY
      end

      let(:aligned_array) do
        <<~RUBY
          array = [a,
            b,
            c,
            d]
        RUBY
      end

      it "registers an offense and corrects misaligned array elements" do
        expect_offense(not_aligned_array)

        expect_correction(aligned_array)
      end

      it "accepts aligned array keys" do
        expect_no_offenses(aligned_array)
      end
    end

    context "when using nested arrays" do
      let(:not_aligned_array) do
        <<~RUBY
          [:l1,
            [:l2,
               [:l3,
                 [:l4]]]]
        RUBY
      end

      it "does not auto-correct array within array with too much indentation" do
        expect_offense(<<~RUBY)
          [:l1,
             [:l2,
             ^^^^^ Use one level of indentation for elements following the first line of a multi-line array.
                [:l3,
                ^^^^^ Use one level of indentation for elements following the first line of a multi-line array.
                  [:l4]]]]
        RUBY

        expect_correction(not_aligned_array)
      end

      it "does not auto-correct array within array with too little indentation" do
        expect_offense(<<~RUBY)
          [:l1,
           [:l2,
           ^^^^^ Use one level of indentation for elements following the first line of a multi-line array.
              [:l3,
              ^^^^^ Use one level of indentation for elements following the first line of a multi-line array.
                [:l4]]]]
        RUBY

        expect_correction(not_aligned_array)
      end
    end

    context "when arrays with heredoc strings" do
      let(:not_aligned_array) do
        <<~RUBY
          var = [
            { :type => 'something',
              :sql => <<EOF
          Select something
          from atable
          EOF
            },
           { :type => 'something',
           ^^^^^^^^^^^^^^^^^^^^^^^ Use one level of indentation for elements following the first line of a multi-line array.
             :sql => <<EOF
          Select something
          from atable
          EOF
           }
          ]
        RUBY
      end

      let(:aligned_array) do
        <<~RUBY
          var = [
            { :type => 'something',
              :sql => <<EOF
          Select something
          from atable
          EOF
            },
            { :type => 'something',
              :sql => <<EOF
          Select something
          from atable
          EOF
            }
          ]
        RUBY
      end

      it "does not indent heredoc strings in autocorrect" do
        expect_offense(not_aligned_array)

        expect_correction(aligned_array)
      end
    end

    context "when each element of array on the new line" do
      let(:aligned_array) do
        <<~RUBY
          array = [
            a,
            b,
            c,
            d
          ]
        RUBY
      end

      let(:not_aligned_array) do
        <<~RUBY
          array = [
            a,
             b,
             ^ Use one level of indentation for elements following the first line of a multi-line array.
            c,
             d
             ^ Use one level of indentation for elements following the first line of a multi-line array.
          ]
        RUBY
      end

      it "accepts the first element being on a new row" do
        expect_no_offenses(aligned_array)
      end

      it "registers an offense and corrects misaligned array elements if the first element being on a new row" do
        expect_offense(not_aligned_array)

        expect_correction(aligned_array)
      end
    end
  end
end
