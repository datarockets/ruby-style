module RuboCop
  module Cop
    module RSpec
      # Check for repeated describes
      #
      # @example
      #
      #    describe 'cool feature' do
      #      # example group
      #    end
      #
      #    describe 'cool feature' do
      #      # example group
      #    end
      #
      class RepeatedDescribe < Cop
        MSG = "Don't repeat describe descriptions".freeze

        def_node_matcher :several_describes?, <<-PATTERN
          (begin (block (send nil? :describe ...) ...)+ )
        PATTERN

        def_node_matcher :extract_doc_string, "(block (send nil? :describe $str ...) ...)"

        def on_begin(node)
          return unless several_describes?(node)

          repeated_describes(node).each { |child| add_offense(child) }
        end

        private

        def repeated_describes(node)
          node
            .children
            .group_by { |child| extract_doc_string(child) }
            .select { |describe, group| describe && group.size > 1 }
            .values
            .flatten
        end
      end
    end
  end
end
