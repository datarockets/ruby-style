module RuboCop
  module Cop
    module RSpec
      # Check for repeated describes
      #
      # @example
      #
      #    context 'cool feature' do
      #      # example group
      #    end
      #
      #    context 'cool feature' do
      #      # example group
      #    end
      #
      class RepeatedContextDescription < Cop
        MSG = "Don't repeat context descriptions".freeze

        def_node_matcher :context_group?, <<-PATTERN
          (begin (block (send nil? :context ...) ...)+ )
        PATTERN

        def_node_matcher :extract_doc_string, "(block (send nil? :context $str ...) ...)"

        def on_begin(node)
          return unless context_group?(node)

          repeated_contexts(node).each { |child| add_offense(child) }
        end

        private

        def repeated_contexts(node)
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
