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
      class RepeatedContextBody < Cop
        MSG = "Don't repeat context block body".freeze

        def_node_matcher :context_group?, <<-PATTERN
          (begin (block (send nil? :context ...) ...)+ )
        PATTERN

        def_node_matcher :extract_metadata, "(block (send _ _ _ $...) ...)"
        def_node_matcher :extract_body, "(block send args $...)"

        def on_begin(node)
          return unless context_group?(node)

          repeated_contexts(node).each { |child| add_offense(child) }
        end

        private

        def repeated_contexts(node)
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
