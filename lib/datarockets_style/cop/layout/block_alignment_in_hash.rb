module DatarocketsStyle
  module Cop
    module Layout
      class BlockAlignmentInHash < RuboCop::Cop::Cop
        include RuboCop::Cop::Alignment
        include RuboCop::Cop::EndKeywordAlignment

        MSG = "Align".freeze
        def_node_matcher :hash_with_block?, <<-PATTERN
          (hash
            <(pair
              ({sym | str} _)
              (block ...)
            ) ...>
          )
        PATTERN

        def on_hash(node)
          return unless hash_with_block?(node)

          node.children.each do |pair_node|
            _key_node, value_node = pair_node.children

            next unless value_node.is_a? RuboCop::AST::BlockNode
            next unless begins_its_line?(value_node.loc.end)

            check_alignment(value_node.children, value_node.loc.column)
          end
        end

        def autocorrect(node)
          RuboCop::Cop::AlignmentCorrector.correct(processed_source, node, column_delta + configured_indentation_width)
        end
      end
    end
  end
end
