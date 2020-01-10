module RuboCop
  module Cop
    module RSpec
      # Check for repeated describes
      #
      # @example
      #
      #    describe 'cool feature' do
      #      it { 2 + 1 }
      #    end
      #
      #    describe 'cool feature 2' do
      #      it { 2 + 1 }
      #    end
      #
      class RepeatedDescribeBody < Cop
        MSG = "Don't repeat describe block body".freeze

        def_node_matcher :several_describes?, <<-PATTERN
          (begin (block (send nil? :describe ...) ...)+ )
        PATTERN

        def_node_matcher :extract_metadata, "(block (send _ _ _ $...) ...)"
        def_node_matcher :extract_body, "(block send args $...)"

        def on_begin(node)
          return unless several_describes?(node)

          repeated_describes(node).each { |child| add_offense(child) }
        end

        private

        def repeated_describes(node)
          node
            .children
            .group_by { |child| [extract_metadata(child), extract_body(child)] }
            .select { |_, group| group.size > 1 }
            .values
            .flatten
        end
      end
    end
  end
end
