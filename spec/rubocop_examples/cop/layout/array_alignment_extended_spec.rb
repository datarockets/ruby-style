# frozen_string_literal: true

module RubocopExamples
  module Cop
    module Lauout
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
      end
    end
  end
end
