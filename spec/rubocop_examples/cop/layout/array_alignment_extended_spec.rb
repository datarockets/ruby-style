# frozen_string_literal: true

module RubocopExamples
  module Cop
    module Layout
      class ArrayAlignmentExtended
        attr_reader :a, :b, :c

        def test
          [a,
            b,
            c]
        end

        def test2
          array = [1, 2, 3,
            4, 5, 6]
          array.join
        end

        def test3
          it "returns himself and his investor" do
            is_expected.to contain_exactly(unaffiliated_investor, broker_investor)
          end
        end
      end
    end
  end
end
